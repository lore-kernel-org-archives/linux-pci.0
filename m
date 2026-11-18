Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794961603;
	b=29rSiJ8+PQSchvdJ7lJU2K57ujlCquCWuaTYEZLZkvVJFaS51CDricPl87MR6+/Wpx2J
	 GOrw+Eay3lHwRAZOBlXWB/d4uxjRJV/b/5faD2cS+FgZC4aht07+MSPkVPimFtBWUHtJZ
	 xIWIZopJJKWlXAswg5GCWGSRSwLr5RCs4Zaj/1Y0GYYtc80fUY1a5dMCTI5lGne1in4lp
	 T90xp4EjZ5bGXMbo4XX+bqHXFEA9a9mPHkt2eBIArI16LLNIBEshA3e545gEBYibhOoq0
	 JBdSQnwfg5C9lGAWuPhwNzzMcEbalZ+jvfORHOSjZE8QQdp7eLANiQQvL60ZG0sc/Yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794961603;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=V8/idSoRxa60yVuvuxTHG+svsK5itnaUZB6//PDgs+Y=;
	b=NYBN3H74YnWEF/81W7B1m64cXyn1+4ajmQJjMfmBdayUAI0s+VLkY0N8ydJXwlAUCqEM
	 LR4sPIE6gHsx78Ty1HwIUSB7TbPn+KZY5MjviqdEGFykd4qS9H4P3htKpsB1sYeGGBA5U
	 6+R7zsWDDgbdMlIFhHEEpIqtIDTn5Xt9UEW3rhF2bvJJt4c/xZqH7QoNyZ/5T01iRH+1N
	 R0v7O721wTYeObuqYyrhYQe1FzBoM5KiNj//0+Zp57mXyA/3PL1jadG+eYMM3IQz1lvou
	 OnGLyKLshXAA28ZzCXWV5Tb7cAYQb+xv4XrxtkyeO4bEbSsuhtWsAA2uOuHB8Dp+7OQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=shazbot.org;
	spf=pass smtp.mailfrom=shazbot.org;
	dkim=pass header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=yboADhoD;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=uAEfQ4je;
	arc=none smtp.remote-ip=103.168.172.158
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6987606A31C
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 00:26:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6987606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=yboADhoD;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=uAEfQ4je
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 27A811400164
	for <linux-pci@vger.kernel.org>; Tue, 17 Nov 2026 19:26:42 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 17 Nov 2026 19:26:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794961602;
	 x=1795048002; bh=V8/idSoRxa60yVuvuxTHG+svsK5itnaUZB6//PDgs+Y=; b=
	yboADhoDFvkdIVf8qW1HRyv4NHCnp/7kVUE8D+bHICMEJT4w2C0q2610InBhBvzO
	JbaV5aQz/frvwAg/ztQjZaLfBzxET5KB2FK8TL3Wy2oQAfQ4oAiIgoRGU6L6PqZo
	QPdwmDvUR+SGthA8l4j4unEpNfbqO/0BAZuTlTDg1xCFAIpUj7MFu/mIE+6CbXB5
	YvgJzklxViaMxLCOFtNQQnU6zB7x2GpumjZD3SvQolMbZsI8aNOJ38LnM5Bm0zHf
	3czjIpt4sknsBBhOyI9XKDLi3P/n1h7+L9SexN2hXnTjJ1r8DM8XQ/nZLmsYdMc4
	wU8E/dhZttX1T7zNpzkKqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794961602; x=
	1795048002; bh=V8/idSoRxa60yVuvuxTHG+svsK5itnaUZB6//PDgs+Y=; b=u
	AEfQ4jep/VqSQnZKuj8d/+3qJe3GvvbhuJL5hy9i4HAlSR/4hOd5t6N+FobufyzL
	Mh1r6m2cm5fM237N2Dk1v6nO4dxv+ACFzrBuEVAQgevEQTMti54/8UN3yw48wEpT
	d6EotXktszs78UZt1FVx7DS6dFJvL0Gauw517UJUSm9KWcvPwq9EVzBLyExlgPE/
	sbaUod6sxLkIrztfwQh8bZVj+qtMtNitTaMgMn4ksRucIqy2QXoqmeiCgdLsGD4O
	PvxC9PL6P87cGPRhY2aBBa09kXyK0zArp3pJ28Na6IvluIVUy5AK7bkXv954j8mq
	z6V0//yXYTd5518sBhvzA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794961602; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+;
	rt=PGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:kCFxXcZG9IRW4SNab/AnFr4C1alixqTVhmj5qe7CkQOkyua
	TOHFlqiMkbr5IKw/YbeHJWkt2ZPoYCMJbGP3DQVLsISbt6jur16mxECvKpZXeFzT
	m5Vx0DiTPVvrk5mfeY6CzPax5uI2IUzGtTKuEPJ8ubrHoXsY5OMYLSZshIPvqwJv
	S/CzqDUa5wowJtSS/E6LuzKuzFx+7yLYtm1pzxDjgu2YTAEEWfcptudpqADCzzHK
	0DeqkMiEZ+fn3Kf8C6BHpncpK5/efgJRJFxwDQfGvyUYi7s1cwrOAvw5pvh3d2jp
	c3sV5v4XciT3Oc67DGJDUWmaiq8KYr1EhDG482A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:wYac0NKm+NeGHfh8T8OT5UGUwGjZZWRzI5xur6Vqi/0=:yTBUT7ksIN2zAre6QifLpTP0c+mMMfgeIMdRwVxBPoU=;
X-ME-Sender: <xms:wPD8ar3RBMFuDZEN5yOl5QICQiPjjx1eD-WtocCexXEOyHc3B7Ko1Q>
    <xme:wPD8ahAdTL1H7VxqjRP3XfECcqwEDcoHU-GtqmM5qLkt72Hb10URJIZkQNHv3eWPf
    SD57Fz5_8V6yugOg-h3iQf7oklLUpwEdnfCFA4nUu8ZLV_oV9KAIOM>
X-ME-Received: <xmr:wPD8aiVrBTI-h7lfwyMN7QlNJJPD0Im67py5-OYqwXieeyaCYNI-Bx8xZAZz-A>
X-ME-Proxy-Cause: dmFkZTEpYZeWt53FpiAM4kDCGUzOck7rfPEJxqhQL5kWkxeezxYO/nYtxVtuytY1d4ZmMx
    QFc+s3ord4eFcQ31FkOV2OPL4/LLiaenZ5wubmUKUTXtaX3zIi6p6MgNgZXVbP7m5hkbWE
    nQn5t72SSph1MPoTq+QVy9nFi7Y6JDy3WtwaztZ6TAp2e8mr9D+284UQDflHZajJM4Nfl0
    LDkAi1cZAXTyUeOjtpUdNXD/kbN6cacIX1BUL4K0EA5DAId0mujN5d/JDTWCkD+kMDqJhg
    HXOvXnqML1ey7mCN6IM3b7hWT5SN1Cr6Mskfeeothlu+dPAil6D5zTHGAOPUjRSGJSmzEj
    VHHL+07tzU9wg5nuA/6cSGanB7NuAfmMRVGJHsBCTluz4G2Dn7ef8q7ysZ0GETqlzzTSyD
    G9kKkGOtFPvvj8ohDrpKD9mwdpgpA73vbC91g4cVokc0TGZrnNhNqpmAJKmm0zVqoOS3zB
    /D7i49GdieGpOYwWeeY/CvSpuD5nfiVNtOD90kX9l+vDYYxBBSsL09zkJYzjA+4P+46b5o
    3r9gjXeNXwEUZh/zmQfWDQTnhcAhsO/gglbRddYva+t2n7iRKi3DhCK25nlqxjfu0ArqCv
    CcRYUocYyZml6FDF6Lr0hmuHnvrRxaNBdO+hCb6XSD/UnoJNd8NBVHFzxolQ
X-ME-Proxy: <xmx:wPD8avXlIEhPbw0NOoNphI6PABBv3q3D9eSNSEqjAHWKa8sGf6ifFA>
    <xmx:wPD8avQ2PeZjwFvwQKuxSXQfqWo1mcsP04ZPJxD4_NlTe5UykoQiAw>
    <xmx:wPD8ahM0_o3xmmeJOUE7QTxE9fGIf2pHqLN3RbVyXVUP2shb6zol4w>
    <xmx:wPD8aruAWy74Buzbu8S6Fk13HuGeVNl_JItbUoXmHyRFhWebp4rmfg>
    <xmx:wvD8atopX67BHANrXRDx2ufeVqe0KildWrrNuvYfQpGR-8NANNOybTql>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Nov 2026 19:26:36 -0500 (EST)
Date: Tue, 17 Nov 2026 16:26:34 -0800
From: Alex Williamson <alex@shazbot.org>
To: "David Matlack" <dmatlack@google.com>
Cc: <kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-pci@vger.kernel.org>, "Adithya Jayachandran"
 <ajayachandra@nvidia.com>, "Alexander Graf" <graf@amazon.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, "Chris Li" <chrisl@kernel.org>, "David
 Rientjes" <rientjes@google.com>, "Jacob Pan"
 <jacob.pan@linux.microsoft.com>, "Jason Gunthorpe" <jgg@nvidia.com>,
 "Jonathan Corbet" <corbet@lwn.net>, "Josh Hilke" <jrhilke@google.com>,
 "Leon Romanovsky" <leonro@nvidia.com>, "Lukas Wunner" <lukas@wunner.de>,
 "Mike Rapoport" <rppt@kernel.org>, "Parav Pandit" <parav@nvidia.com>,
 "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Pranjal Shrivastava"
 <praan@google.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Randy Dunlap"
 <rdunlap@infradead.org>, "Saeed Mahameed" <saeedm@nvidia.com>, "Samiullah
 Khawaja" <skhawaja@google.com>, "Shuah Khan" <skhan@linuxfoundation.org>,
 "Vipin Sharma" <vipinsh@google.com>, "William Tu" <witu@nvidia.com>, "Yi
 Liu" <yi.l.liu@intel.com>, alex@shazbot.org
Subject: Re: [PATCH v10 09/13] PCI: liveupdate: Adopt ACS controls in
 incoming preserved devices
Message-ID: <20261117162634.2e04ad3f@shazbot.org>
In-Reply-To: <DMXSQHZG5L27.2NIIT7F6FW0ME@google.com>
References: <20261013162529.1928093-1-dmatlack@google.com>
	<20261013162529.1928093-10-dmatlack@google.com>
	<20261116170942.720b06fd@shazbot.org>
	<DMXSQHZG5L27.2NIIT7F6FW0ME@google.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Nov 2026 13:16:21 -0800
"David Matlack" <dmatlack@google.com> wrote:

> On Mon Nov 16, 2026 at 5:09 PM PST, Alex Williamson wrote:
> > On Tue, 13 Oct 2026 16:25:25 +0000
> > David Matlack <dmatlack@google.com> wrote:  
> >> +int pci_liveupdate_adopt_acs(struct pci_dev *dev)
> >> +{
> >> +	/*
> >> +	 * Check if the device was preserved over a previous Live Update (even
> >> +	 * if it has already gone through pci_liveupdate_finish()). This ensures
> >> +	 * that the device continues to use the ACS controls established by the
> >> +	 * previous kernel.
> >> +	 */
> >> +	if (!dev->liveupdate.was_incoming)
> >> +		return -EINVAL;
> >> +
> >> +	/*
> >> +	 * The previous kernel should not have preserved any devices that
> >> +	 * require device-specific quirks to enable ACS, but if such a device is
> >> +	 * detected (e.g. new device-specific ACS quirk in the current kernel),
> >> +	 * log a big warning and fall back to the normal enable ACS path.
> >> +	 */
> >> +	if (pci_need_dev_specific_enable_acs(dev)) {
> >> +		pci_warn(dev, "Device-specific quirk required to enable ACS!\n");
> >> +		WARN_ON_ONCE(true);
> >> +		return -EINVAL;
> >> +	}  
> >
> > This looks pretty unsafe and the comment is only explaining how we
> > might get here, not why we shouldn't panic.  IIUC, the IOMMU lho
> > support requires singleton groups, but I'm not sure what it does if a
> > group becomes non-singleton in the new kernel (such as via a new quirk).
> >
> > Is a warning related to what might be a parent bridge rather than the
> > endpoint device, really sufficient here?  Thanks,  
> 
> It's not necessarily safe. The new quirk could change how TLPs are being
> routed while a downstream preserved device is still sending memory
> transactions.
> 
> I think a better approach would be for a preserved device to always
> adopt the ACS controls left by the previous kernel, and keep them
> across resets through the ACS save state. So a new device-specific quirk
> for the device is ignored, apart from logging a warning. IOW, new ACS
> quirks only take effect on cold boot.
> 
> If a preserved device has an ACS capability but no save state (i.e. the
> allocation failed), then we can panic, since its adopted controls would
> be lost by the first reset..
> 
> Roughly:
> 
> 	int pci_liveupdate_adopt_acs(struct pci_dev *dev)
> 	{
> 		if (!dev->liveupdate.was_incoming)
> 			return -EINVAL;
> 
> 		if (pci_need_dev_specific_enable_acs(dev))
> 			pci_warn(dev, "Ignoring ACS quirk, adopting ACS controls from previous kernel\n");
> 
> 		if (dev->acs_cap && !pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_ACS))
> 			panic("%s: No ACS save state for preserved device\n",
> 			      pci_name(dev));
> 
> 		return 0;
> 	}
> 
> The panic would only happen if allocating the save state fails. Ideally
> I'd like save state allocation failures to cause the whole device setup
> to fail. That's something I'm hoping to do in the future on top of the
> pci_save_state rework [1], and then we can remove this panic. Until
> then, the panic is constrained to Live Update, and the allocation
> shouldn't fail in practice.
> 
> As for IOMMU groups: Sami's IOMMU Live Update series refuses to let any
> device join a group that contains a preserved device, in both the
> outgoing and incoming kernel (__iommu_probe_device() fails with -EBUSY)
> [2][3]. So if the new kernel considers the path less isolated than the
> previous kernel did, e.g. because of a new quirk, the group grows and
> the IOMMU core refuses the second device rather than putting both in
> one group. The system comes up with that device unavailable, which can
> be debugged and recovered by rebooting, instead of panicking.
> 
> [1] https://lore.kernel.org/linux-pci/20261106004218.604799-1-dmatlack@google.com/
> [2] https://lore.kernel.org/linux-iommu/20261110040828.1774343-6-skhawaja@google.com/
> [3] https://lore.kernel.org/linux-iommu/20261110040828.1774343-13-skhawaja@google.com/
> 
> Does that sound reasonable?

Yes, reasonable.  ACS is deterministically managed via standard
controls on the source, continue that after update, disregarding any
new quirks that have been added (to the extent that they fall within
the current framework), IOMMU enforces singleton groups on both ends to
avoid violations.  I don't know how to do better than that.  Thanks,

Alex
