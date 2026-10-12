Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABFA52CCDF
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 17:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791913793; cv=none; b=Hmh9WozvQ4AWP/pEC9POmCuGh3uO7x0fDyFgcQqC9joO+ogSfd5IDMgsA4GQVDdfvI86BHcFeR+yAHnL1n/FBCcglDi+C/5AikuSan/pT2vrSW/FyY4Ix0yYqNR5Lgb3cvdU1DeDLHNVKjWiYdD06gFXkOtOrhO+VtGNWUuUBSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791913793; c=relaxed/simple;
	bh=dEptTwNX9Sq3lL7fDHLWKReZfufeO69vQyYwqPmjcPs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QpZy8TwP3dgnvR+2pM7Ix8+PbXzFxnl5gZg3vyr90Se0nkxktYIIBMZbNQYTiy3ir/Z/6/YVOavVOGdCvMMiE1nMNMoyTCloccvIng+mtfDiQ0xCu7V+UCJwR5TqxLaT9/26YqRAn0jM9xB/Or4V60GBAzayHcYGy9gBCfkGaF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KpNzg/Z6; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KpNzg/Z6"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id A1831C653FE
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 17:50:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 095DC60362
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 17:49:49 +0000 (UTC)
Received: by mail.galae.net (Postcow, from userid 0)
	id A180E11D717E5; Tue, 13 Oct 2026 19:49:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791913788; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=kSIOvrEHM3a5XmLq4o4Vz8QQhg7cfJBqO8WQZOEPSfo=;
	b=KpNzg/Z6lJF5N4brDHRim2S6Uf5HjPtRm7SGmapGtBC/1cVwP6t7kShxbfQIFjS/08PXh4
	t6i6FuPfX8ZKVYWYap8hVe4kpG0m29Z9paSzyJqVgZ0fZU0KtxAasCuT5GbEG83jVH1Wd7
	EeL4ua6V9fIESlETd4IP2PG6oiX55RD2NGffQ13Nq0S8wHuxZrCtwOg/F71ycDTMaNKrtJ
	v9YV5ncjnjVNsmLQ+WzAOuTIR6DK5O15AODyYnBVZZ6TucysjO9ny9ZNNsRRHqDZofvdMK
	I57xSbzY7KuO0XjyuG2bTTFypCORRzz+5U+NbjOzflTpyK8GWKyhK3/YQsBOMA==
Authentication-Results: mail.galae.net;
	none
AF:
NF:0
PS:10
SRH:1
SFN:
DSR:
MID:
CFG:
PT:0
S:herve.codina@bootlin.com
RQ:
SSV:mail.galae.net
NSV:
SSH:
R:<andriy.shevchenko@linux.intel.com>,<icheng@nvidia.com>,<andrew@lunn.ch>,<robh@kernel.org>,<saravanak@kernel.org>,<gregkh@linuxfoundation.org>,<rafael@kernel.org>,<dakr@kernel.org>,<bhelgaas@google.com>,<ckeepax@opensource.cirrus.com>,<rf@opensource.cirrus.com>,<david.rhodes@cirrus.com>,<linusw@kernel.org>,<djrscally@gmail.com>,<heikki.krogerus@linux.intel.com>,<sakari.ailus@linux.intel.com>,<brgl@kernel.org>,<lenb@kernel.org>,<dave@stgolabs.net>,<jic23@kernel.org>,<dave.jiang@intel.com>,<alison.schofield@intel.com>,<vishal.l.verma@intel.com>,<djbw@kernel.org>,<iweiny@kernel.org>,<ming.li@zohomail.com>,<lizhi.hou@amd.com>,<driver-core@lists.linux.dev>,<linux-kernel@vger.kernel.org>,<linux-pci@vger.kernel.org>,<linux-sound@vger.kernel.org>,<patches@opensource.cirrus.com>,<linux-gpio@vger.kernel.org>,<linux-acpi@vger.kernel.org>,<linux-cxl@vger.kernel.org>,<allan.nielsen@microchip.com>,<horatiu.vultur@microchip.com>,<daniel.machon@microchip.com>,<steen.hegelund@microchip.com>,<luca.c
 eresoli@bootlin.com>,<thomas.petazzoni@bootlin.com>,<stable+noautosel@kernel.org>
MAID:1
X-Claws-Privacy-System:
X-Claws-Sign:0
SCF:#imap/herve.codina@bootlin.com@mail.galae.net/Sent
RMID:#imap/herve.codina@bootlin.com@mail.galae.net/INBOX	10429	ar62bJzBEAhGL2iu@ashevche-desk.local
X-Claws-Auto-Wrapping:0
X-Claws-Auto-Indent:0
X-Claws-End-Special-Headers: 1
Date: Mon, 12 Oct 2026 15:38:11 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Richard Cheng <icheng@nvidia.com>, Andrew Lunn <andrew@lunn.ch>, Rob
 Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Charles Keepax <ckeepax@opensource.cirrus.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>, David Rhodes
 <david.rhodes@cirrus.com>, Linus Walleij <linusw@kernel.org>, Daniel Scally
 <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Bartosz Golaszewski
 <brgl@kernel.org>, Len Brown <lenb@kernel.org>, Davidlohr Bueso
 <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>, Dave Jiang
 <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, Lizhi Hou
 <lizhi.hou@amd.com>, driver-core@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-sound@vger.kernel.org, patches@opensource.cirrus.com,
 linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-cxl@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, Daniel Machon
 <daniel.machon@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 stable+noautosel@kernel.org
Subject: Re: [PATCH v12 10/10] PCI: of: Avoid np->data usage for the node
 changeset
Message-ID: <20261012153811.2cdcaf89@bootlin.com>
In-Reply-To: <ar62bJzBEAhGL2iu@ashevche-desk.local>
References: <20261001142815.277550-1-herve.codina@bootlin.com>
	<20261001142815.277550-11-herve.codina@bootlin.com>
	<ar62bJzBEAhGL2iu@ashevche-desk.local>
Organization: Bootlin
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: None
X-Rspamd-Queue-Id: A180E11D717E5
X-Spamd-Result: default: False [2.40 / 30.00];
	SUSPICIOUS_RECIPS(1.50)[];
	DATE_IN_PAST(1.00)[28];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.00)[38.57%];
	ARC_NA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	BCC(0.00)[];
	TAGGED_RCPT(0.00)[noautosel];
	DKIM_SIGNED(0.00)[bootlin.com:s=dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[42];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	URIBL_BLOCKED(0.00)[localhost:rdns,localhost:helo,intel.com:email,bootlin.com:mid];
	FREEMAIL_CC(0.00)[nvidia.com,lunn.ch,kernel.org,linuxfoundation.org,google.com,opensource.cirrus.com,cirrus.com,gmail.com,linux.intel.com,stgolabs.net,intel.com,zohomail.com,amd.com,lists.linux.dev,vger.kernel.org,microchip.com,bootlin.com];
	MAILCOW_DOMAIN_HEADER_FROM(0.00)[bootlin.com];
	TO_DN_SOME(0.00)[]

Hi Andy,

On Thu, 1 Oct 2026 22:37:16 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Thu, Oct 01, 2026 at 04:28:10PM +0200, Herve Codina wrote:
> > of_pci_remove_node() and of_pci_remove_host_bridge_node() check
> > whether the node is dynamic but not whether it has valid private data.
> > 
> > During the node creation, an OF changeset is used and this changeset is
> > stored in np->data to be available for removal functions.
> > 
> > If, for instance, a PCI host bridge is created using a device-tree
> > overlay, the related node will have the dynamic flag set but np->data
> > will be NULL. This leads to NULL pointer dereferences.
> > 
> > Checking for a non-NULL np->data pointer to determine if the node has
> > been created by the PCI node creation process is not enough. Indeed,
> > on some platforms like PowerPC, the OF_RECONFIG_ATTACH_NODE notifier
> > (e.g., in the pci_dn_reconfig_notifier() function) intercepts node
> > additions and populates np->data with its own structure, such as a
> > struct pci_dn. In that case, np->data is not NULL but it is not related
> > to our changeset stored during the PCI node process creation.
> > 
> > Avoid the usage of np->data to store the changeset used during the PCI
> > node creation. Store our changeset in a more relevant structure: either
> > struct pci_dev when the node is created for a PCI device or struct
> > pci_host_bridge when the node is created for the PCI host bridge.
> > 
> > With that done, no ambiguity remains on removal. Indeed, this changeset,
> > if non-NULL, is the one used during PCI node creation. Check and use
> > this changeset on the removal process.  
> 
> ...
> 
> >  void of_pci_remove_node(struct pci_dev *pdev)  
> 
> >  	struct device_node *np;
> >  
> >  	np = pci_device_to_OF_node(pdev);
> > -	if (!np || !of_node_check_flag(np, OF_DYNAMIC))
> > +	if (!pdev->cset || !np)
> >  		return;  
> 
> Wouldn't be better to split this conditional to two?
> 
> 	if (!pdev->cset)
> 		return;
> 
> 	np = pci_device_to_OF_node(pdev);
> 	if (!np)
> 		return;

Yes indeed, this will improve readability. I will update in the next
iteration.

Also I will perform the same kind of modification in
of_pci_remove_host_bridge_node(), the same kind of check is present.

Best regards,
Hervé
