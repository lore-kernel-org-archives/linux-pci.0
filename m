Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59055 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751141AbaJ1VvP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 28 Oct 2014 17:51:15 -0400
Message-ID: <1414533068.27420.226.camel@ul30vt.home>
Subject: Re: Hard and silent lock up since linux 3.14 with PCIe pass through
 (vfio)
From: Alex Williamson <alex.williamson@redhat.com>
To: Andreas Hartmann <andihartmann@freenet.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>
Date: Tue, 28 Oct 2014 15:51:08 -0600
In-Reply-To: <544B3D14.70907@maya.org>
References: <20140923210318.498dacbd@dualc.maya.org>
					 <1411502866.24563.8.camel@ul30vt.home> <5437A958.3000201@maya.org>
					 <CAErSpo5kkk4itqqmCMU=08-XMcDknur8VY++F3A2LajdvTptOA@mail.gmail.com>
					 <5437F1F5.3010706@maya.org>
					 <CAErSpo6DuWEcJb_gfS=5JnKN8b4DXXV9+u-CRa8m3db0dbzpsQ@mail.gmail.com>
					 <543804BC.3080307@maya.org>
					 <CAErSpo450czUtAM104o+RS=yOcmP+3MKMH7mYk=UYhVJ2+cfSQ@mail.gmail.com>
					 <20141011003219.560cca97@dualc.maya.org>
					 <20141010225408.GA24493@google.com> <5438CC1E.3060407@maya.org>
					 <1413360267.4202.70.camel@ul30vt.home> <54406B34.1050808@maya.org>
					 <1413925580.4202.189.camel@ul30vt.home>
				 <1413927152.4202.195.camel@ul30vt.home> <5447D9D9.9030909@maya.org>
			 <1414010215.4202.275.camel@ul30vt.home> <54492606.5090308@maya.org>
		 <1414082022.27420.39.camel@ul30vt.home> <54493BFA.8010609@maya.org>
	 <1414093023.27420.40.camel@ul30vt.home> <544B3D14.70907@maya.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, 2014-10-25 at 08:03 +0200, Andreas Hartmann wrote:
> 
> Out of interest:
> Bjorn's patch disables vc save/restore support - and the machine works
> fine again. Why is it needed at all if it seems to work perfectly w/o
> it? What's the additional benefit? Or in other words: What am I missing
> until today :-) ? What would be better? What could I do more?


You're right, in the configuration you have the endpoint device has a
Virtual Channel capability but the upstream root port does not.  The
spec is not at all clear about defining the endpoints for enabling
Virtual Channel in each type of configuration, but I think that if we
have an upstream port that does not support Virtual Channel, we can skip
the save/restore.  Please test the patch below.

I'm also still completely confused about whether this is a VC
save/restore issue or a bus reset issue.  You originally bisected this
back to the VC save/restore patch, but you also found that a manual,
setpci-based bus reset triggered a system hang.  I believe that
re-ordering the kernel reset mechanisms also triggered this.  Since
recent versions of QEMU are going to favor a bus reset over PM reset, I
don't have a lot of confidence that we're actually solving the problem
for you.  Please make sure to test with a recent QEMU to be sure we'll
do a bus reset.  Thanks,

Alex


diff --git a/drivers/pci/vc.c b/drivers/pci/vc.c
index 7e1304d..6d13d34 100644
--- a/drivers/pci/vc.c
+++ b/drivers/pci/vc.c
@@ -339,6 +339,25 @@ static int pci_vc_do_save_buffer(struct pci_dev *dev, int pos,
 	return buf ? 0 : len;
 }
 
+/**
+ * pci_vc_needs_save - Determine whether a VC capability needs to be saved
+ * @dev: device
+ * @id: VC capability ID (VC/VC9/MFVC)
+ *
+ * In configurations where we have a VC or MFVC capability, but the upstream
+ * device does not, we assume that VC save (and therefore restore) is not
+ * necessary.  The intention is to only do VC save/restore in configuration
+ * where it's necessary and hopefully avoid reset issues.
+ */
+static bool pci_vc_needs_save(struct pci_dev *dev, u16 id)
+{
+	if (id == PCI_EXT_CAP_ID_VC9 || pci_is_root_bus(dev->bus) ||
+	    pci_find_ext_capability(dev->bus->self, PCI_EXT_CAP_ID_VC))
+		return true;
+
+	return false;
+}
+
 static struct {
 	u16 id;
 	const char *name;
@@ -362,7 +381,7 @@ int pci_save_vc_state(struct pci_dev *dev)
 		struct pci_cap_saved_state *save_state;
 
 		pos = pci_find_ext_capability(dev, vc_caps[i].id);
-		if (!pos)
+		if (!posi || !pci_vc_needs_save(dev, vc_caps[i].id))
 			continue;
 
 		save_state = pci_find_saved_ext_cap(dev, vc_caps[i].id);
@@ -422,7 +441,7 @@ void pci_allocate_vc_save_buffers(struct pci_dev *dev)
 	for (i = 0; i < ARRAY_SIZE(vc_caps); i++) {
 		int len, pos = pci_find_ext_capability(dev, vc_caps[i].id);
 
-		if (!pos)
+		if (!pos || !pci_vc_needs_save(dev, vc_caps[i].id))
 			continue;
 
 		len = pci_vc_do_save_buffer(dev, pos, NULL, false);


