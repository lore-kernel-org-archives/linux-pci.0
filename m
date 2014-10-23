Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout1.freenet.de ([195.4.92.91]:39152 "EHLO mout1.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751721AbaJWRkE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 23 Oct 2014 13:40:04 -0400
Message-ID: <54493BFA.8010609@maya.org>
Date: Thu, 23 Oct 2014 19:33:46 +0200
From: Andreas Hartmann <andihartmann@freenet.de>
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@redhat.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>
Subject: Re: Hard and silent lock up since linux 3.14 with PCIe pass
 through (vfio)
References: <20140923210318.498dacbd@dualc.maya.org>			 <1411502866.24563.8.camel@ul30vt.home> <5437A958.3000201@maya.org>			 <CAErSpo5kkk4itqqmCMU=08-XMcDknur8VY++F3A2LajdvTptOA@mail.gmail.com>			 <5437F1F5.3010706@maya.org>			 <CAErSpo6DuWEcJb_gfS=5JnKN8b4DXXV9+u-CRa8m3db0dbzpsQ@mail.gmail.com>			 <543804BC.3080307@maya.org>			 <CAErSpo450czUtAM104o+RS=yOcmP+3MKMH7mYk=UYhVJ2+cfSQ@mail.gmail.com>			 <20141011003219.560cca97@dualc.maya.org>			 <20141010225408.GA24493@google.com> <5438CC1E.3060407@maya.org>			 <1413360267.4202.70.camel@ul30vt.home> <54406B34.1050808@maya.org>			 <1413925580.4202.189.camel@ul30vt.home>		 <1413927152.4202.195.camel@ul30vt.home> <5447D9D9.9030909@maya.org>	 <1414010215.4202.275.camel@ul30vt.home> <54492606.5090308@maya.org> <1414082022.27420.39.camel@ul30vt.home>
In-Reply-To: <1414082022.27420.39.camel@ul30vt.home>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Alex Williamson wrote:
[...]
> If you use Bjorn's previous patch to disable VC save/restore and my
> patch to reorder the reset mechanisms, does echo 1 > reset for the sysfs
> entry for the device also still cause a hang?

Yes - it's hanging too (w/ vfio bound to the device - didn't test other
possibilities).


Regards,
Andreas
