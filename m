Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=83.223.95.204
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795040240;
	b=P383Vb8of+c4Gm3wfNzuyePR06seDl4sMjVNztdHyb0pbuQSog5j/qnPYr33dZCQH6WP
	 A4liAEWW/twAMFAm5uiLFRLnLIhgssywsfTrSnmb0vMWKBW2ttVjxHNgQK3S9dGugRuBo
	 SirkOqbOaXAB73XeIK5NhEJLhEfhJZGNd2+oxPahGrX90fPYJUd8V+cnUuwHc8lp34GTl
	 I5HscbxvJ5PThFGL4Mhskg1HgOvPxfOqBxj0/ZTuvRdk5dpYXOxN+guF1rxBAHKqLAFfN
	 6wNIn9HHiLZtjZOROrZhb6fKjWFYEf59oaKE/PhNHxyE11J7/lj1Eek3Hu8P59QGGtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795040240;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=OYsvEI5KoJNPfvtyr1P+eJvz19e9MIzY1Iy57nVmND4=;
	b=Hn41Vbc9qAq12bHnNIenUJaZG7WPIw/CBhEsGjPQwog2pR2K1gxGLw0sS89fkjm9DJr3
	 Ww0n6z6SSlyf6h9nBRUMLxMhOtCr9Ic1sszeCFsTbt577CvmC8JiC5x+xr5rJg/z1ZC1/
	 BCk6FxEUMcjbcDHYYcS1GIxInST7ltRwrA++yqGITt5nOGwh1z2GxZRhSs2nUli6mftFa
	 6LWKl/oZU5vKyl88kv3icMnXGR5AXhoDRcVPueS89kl5MrlEgAiDCp2Iw/uavHbJd86g1
	 nEYMetWWQ7SkcuFmXgVEaYXaKfOLwcpPrDTwwqYVcJERmVQuW1+eYVHjWjew1mdFRdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=wunner.de;
	spf=pass smtp.mailfrom=wunner.de;
	arc=none smtp.remote-ip=83.223.95.204
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E58C606A320
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 22:17:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E58C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 1E7D56B4;
	Wed, 18 Nov 2026 23:17:11 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 08B3C600DF02; Wed, 18 Nov 2026 23:17:11 +0100 (CET)
Date: Wed, 18 Nov 2026 23:17:10 +0100
From: Lukas Wunner <lukas@wunner.de>
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 7/7] PCI/AER: Enable baseline capability error
 reporting
Message-ID: <av4j5j9-In1uWC8T@wunner.de>
References: <cover.1794997749.git.lukas@wunner.de>
 <40e4bd7f25b37af1bdc48a13be140bdd8e7d81ab.1794997749.git.lukas@wunner.de>
 <sashiko-outbox-220816@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-220816@kernel.org>

On Wed, Nov 18, 2026 at 11:19:03AM +0000, sashiko-bot@kernel.org wrote:
> Does allocating dev->aer_info for all PCIe devices cause
> aer_stats_attrs_are_visible() to expose the aer_rootport_total_err_* sysfs
> attributes on Root Ports and RCECs that lack an AER Extended Capability?
> 
> drivers/pci/pcie/aer.c:aer_stats_attrs_are_visible() {
> 	...
> 	if (!pdev->aer_info)
> 		return 0;
> 
> 	if ((a == &dev_attr_aer_rootport_total_err_cor.attr ||
> 	     a == &dev_attr_aer_rootport_total_err_fatal.attr ||
> 	     a == &dev_attr_aer_rootport_total_err_nonfatal.attr) &&
> 	    ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT) &&
> 	     (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_EC)))
> 		return 0;
> 	...
> }
> 
> Those counters are only updated from PCI_ERR_ROOT_STATUS in the AER
> capability and Documentation/ABI/testing/sysfs-bus-pci-devices-aer states
> that they only appear under AER-capable Root Ports or RCECs, so
> aer_stats_attrs_are_visible() should also require pdev->aer_cap for them.

A valid point.

> > @@ -1204,8 +1206,11 @@ static bool is_error_source(struct pci_dev *dev, struct aer_err_info *e_info)
> >  	if (!(reg16 & PCI_EXP_AER_FLAGS))
> >  		return false;
> >  
> > -	if (!aer)
> > -		return false;
> > +	if (!aer) {
> > +		pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &reg16);
> > +		return reg16 & severity2devsta[e_info->severity] &&
> > +		       !PCI_POSSIBLE_ERROR(reg16);
> > +	}
> 
> Does checking PCI_EXP_AER_FLAGS in dev's own PCI_EXP_DEVCTL prevent
> is_error_source() and clear_status_iter() from working on SR-IOV Virtual
> Functions?
> 
> Per PCIe r7.1 sec 7.5.3.4 and sec 9.5.1.2, the PCI_EXP_AER_FLAGS bits in
> PCI_EXP_DEVCTL are RsvdP and hardwired to 0b on VFs, which inherit the
> associated Physical Function's PCI_EXP_DEVCTL settings while implementing
> per-VF status bits in PCI_EXP_DEVSTA.  Reading PCI_EXP_DEVCTL on a VF
> therefore always sees 0 for PCI_EXP_AER_FLAGS, so is_error_source() never
> checks PCI_EXP_DEVSTA on VFs and clear_status_iter() never clears it;
> meanwhile pci_enable_pcie_error_reporting() writes 1s to those RsvdP bits on
> VFs.

Hallucination.  Section 7.5.3.4 does not say anything about error bits being
"RsvdP and hardwired to 0b on VFs".  There is no section 9.5.1.2 in PCIe r7.1.

> >  	/* The device might not support AER */
> > -	if (!aer)
> > -		return 0;
> > +	if (!aer) {
> > +		if (info->severity != AER_CORRECTABLE) {
> > +			pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &devsta);
> > +			if (devsta & PCI_EXP_DEVSTA_URD &&
> > +			    !PCI_POSSIBLE_ERROR(devsta))
> > +				info->status = PCI_ERR_UNC_UNSUP;
> > +		}
> > +		return 1;
> > +	}
> 
> [Severity: Medium]
> Should the !aer branch check info->severity == AER_NONFATAL instead of
> info->severity != AER_CORRECTABLE?
> 
> Without an AER capability, error severities are fixed to their defaults where
> Unsupported Request is always Non-Fatal (PCIe r7.1 sec 6.2.7),

Indeed checking against AER_NONFATAL makes more sense here, although this is
nowhere near as critical an issue as sashiko thinks:

> yet PCI_EXP_DEVSTA_URD is also set by prior Advisory Non-Fatal or Non-Fatal
> Unsupported Requests (sec 6.2.5 and 7.5.3.5).

Advisory Non-Fatal Errors are not signaled on AER-incapable devices
(as stated in the commit message).

> When an AER_FATAL error occurs
> on an AER-incapable device, reading PCI_EXP_DEVSTA accesses config space on
> an Endpoint or Upstream Port whose link may be down, and any set
> PCI_EXP_DEVSTA_URD bit causes aer_print_error() to misreport the fatal error
> as UnsupReq

No, the "!PCI_POSSIBLE_ERROR(devsta)" prevents that.

Below is a fixup patch for the two valid sashiko findings:

-- >8 --

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 3c28afca5d03..83682bc7764e 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -680,12 +680,16 @@ static umode_t aer_stats_attrs_are_visible(struct kobject *kobj,
 	if (!pdev->aer_info)
 		return 0;
 
-	if ((a == &dev_attr_aer_rootport_total_err_cor.attr ||
-	     a == &dev_attr_aer_rootport_total_err_fatal.attr ||
-	     a == &dev_attr_aer_rootport_total_err_nonfatal.attr) &&
-	    ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT) &&
-	     (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_EC)))
-		return 0;
+	if (a == &dev_attr_aer_rootport_total_err_cor.attr ||
+	    a == &dev_attr_aer_rootport_total_err_fatal.attr ||
+	    a == &dev_attr_aer_rootport_total_err_nonfatal.attr) {
+		if ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT) &&
+		    (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_EC))
+			return 0;
+
+		if (!pdev->aer_cap)
+			return 0;
+	}
 
 	return a->mode;
 }
@@ -1545,7 +1549,7 @@ int aer_get_device_error_info(struct aer_err_info *info, int i)
 
 	/* The device might not support AER */
 	if (!aer) {
-		if (info->severity != AER_CORRECTABLE) {
+		if (info->severity == AER_NONFATAL) {
 			pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &devsta);
 			if (devsta & PCI_EXP_DEVSTA_URD &&
 			    !PCI_POSSIBLE_ERROR(devsta))
