Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC32F4A1399;
	Wed,  8 Jul 2026 18:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783535157; cv=none; b=GidrHebWISCuVwliAwABVIpPeeNeF73uIdNYwY4jM6ehgftkhbJBoy77DzaMmZNgy5RyvxwMGOb7/uGKEv1wW3Zn4YsXSdYPu6ZAjClxZvlcEVJyyI1UC3gHdkiZXlf8gDRcRdnKPRE2gEpfPAfiM3U9AagOYin8WLka3m22SiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783535157; c=relaxed/simple;
	bh=V4pNRQdfsU2Q+UdtgQUGURgfIwgmkzRsviSmEh0eUBg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=s2ZcI9krmTHX2wJvbYtGX+cgqA/R8+KeDO8v9mXBSYwILHembb9o3BpiZLDxqzN5b/hCJUc9ABq2XHqXj6SzSNdPu0amKkWmMvIq/Do3ioLsbgl8iD0CBvhPa+Mwj6DLdRy+nBGg9hrSxqFhqJJnFXcmuGvkfAkzscmzQ/eyKVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3gCfrbm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3gCfrbm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D71A61F00A3D;
	Wed,  8 Jul 2026 18:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783535156;
	bh=jYwYNenlyziXQfvfIuCDOhXY8D2mRzdCuvc9UX6ScDE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=U3gCfrbmY6UPWqcoxLOj68Lhms4I5Zdpj1f5t9/q75TdPVjP59MwRzIeo3YZs8XtD
	 Ogw0gNOws1Vy/gArfrM2//wncQunTIdTqtLWFBwYt0R5H08PdDHtnteliBnf19zx3Z
	 5uP7F9SGP+Qh9qqFsV+V3qxh/PUh6hVQVNh/Fmi8m6B8FSKDXltqPj+eZO8RFl9Br5
	 pAOv6hHUKABZNSK1Fb8Kmw97/t9RPU0rzLad3BnDoeS9ZD2rlLA0ThTN3UM5emHQ+z
	 Dg3pIKdUIloW9S5qLwXZ6NxyADexCAJPsI4TuSoYWKuWgnTzm/UY3LHDkBSS6B3JLi
	 8hbZIQqPhiqOQ==
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id ED7CDF4006B;
	Wed,  8 Jul 2026 14:25:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 08 Jul 2026 14:25:54 -0400
X-ME-Sender: <xms:MpZOavaYzI3nc5qYN7nc8vHvO8QF0qr_UIO2SkxaseX4NunYxg9jPw>
    <xme:MpZOaqOPg0XOjuxYUMOoHCPPr48h7k4XwAymvs5wtrKEWTb49ZnwNd5TOTXn1Mu8e
    sB0aErl5-6-VwPMwHymVrbDinQ7ImnWAcQH4TLxbKaCRMQZdqlISKo>
X-ME-Received: <xmr:MpZOatXTpVhxYErgTgJ2JrX0Lfc1m0yTTvdP3IyX7cLJdf2einLLnYFBENMAP3EZE4DmkJdh9UJwMxNvM5i6gDTtbSnl63znJMs>
X-ME-Proxy-Cause: dmFkZTFyjdKvwCxsF7rNQ2i+5I0f7WGXzE30oPy7NFcJn0i2qkGF7koT/Gc47MF71emz9i
    0R9fuBMOrnUhverJTo3lolikYx6hS+yT0BlhrKJADnSkPmAXL0Oa7ZaNuadxYP3AzYzfp6
    /yfEYCl5VVE5z8VDAa0AdVrnNHfW7Rh/rPR1e1MZu/4j05pkFXP/8OynexByPhWi0QHCRC
    DgGXwBcLnNJBmXRLEtPHkPIqIYf9nX4x+bvFMY67wS5q316LPdv4j3pBWqzKBy/EBztQBW
    +zk6D8/2k3+7sOWGcwZE3rfOeXklqpwLcoQf7kQxPBz97VyyiqDwNkdWI33aFFjO3yNwas
    vXeGU3e6NaFH8Alw+Ss2eSdL2HHvoNeIgzyanibY4p0BgtijBnfMD2hTfN7n74ocoxOx6j
    WGZx/ysjOLivLd1jNVD3bZI5y9hj0TeYL0wbinbwJEzsQUiesvGvdbGNxQXaNATfmg51Pa
    wOazBgwPalKYzc26q8NRR44p6QPR3nVDBr06aaUtIvE/LJ4CdVNPAN5bC9NbDr9rekvOCg
    avRxbU0JJyYa5LsjB9CR4uNB9UBMnUNURMT5tDAAZRX3Yl4uuLRIzZ2/b1NgPjk6vFoc6u
    MuNkNfLF+e1pH425hP9Uh1WbCFLscLD6kZgUl13pJuIO5HSRwQwrMS+T5eRg
X-ME-Proxy: <xmx:MpZOavLM9uvnlnYQ273EqB2MkadP7ZiOty4DqeKzRmQrmx66KI2Jtg>
    <xmx:MpZOaopF2UWoD7qUe3F-PhgpQTkbGngCgyzsmyMQaJShQ3nrm1_2Dw>
    <xmx:MpZOamxpM-Qhr_btP9JDQD8qdzHQ6OTwj5-Yk6QeaG_F0Zs0ooUnSQ>
    <xmx:MpZOasv4w_uNwvzARn6r_olYSNlvKckapCt2SdC5UkRF9pcJfe5HOg>
    <xmx:MpZOav3Ohftey-eaUtEQ87wMW5ZP6OINVzsdh1kztubotKnpV80Wh9xq>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 14:25:54 -0400 (EDT)
Date: Wed, 08 Jul 2026 11:25:53 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: Alexey Kardashevskiy <aik@amd.com>, 
 Dan Williams <djbw@kernel.org>, 
 linux-coco@lists.linux.dev
Cc: linux-pci@vger.kernel.org, 
 driver-core@lists.linux.dev, 
 ankita@nvidia.com, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Lukas Wunner <lukas@wunner.de>, 
 Xu Yilun <yilun.xu@linux.intel.com>, 
 "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Message-ID: <6a4e963141e3d_2f3f24100dc@djbw-dev.notmuch>
In-Reply-To: <e42b9ef3-a177-4e38-8aad-c3f4061f1b64@amd.com>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <20260705220819.2472765-7-djbw@kernel.org>
 <e42b9ef3-a177-4e38-8aad-c3f4061f1b64@amd.com>
Subject: Re: [PATCH 06/15] PCI/TSM: Add device evidence support
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Alexey Kardashevskiy wrote:
> On 6/7/26 08:08, Dan Williams wrote:
> > Register the PCI Trusted Execution Environment Security Manager (TSM)
> > framework with the device-evidence netlink ABI. The security operations
> > that PCI core coordinates with a device security manager (DSM) through a
> > platform TEE security manager (TSM), builds upon the SPDM protocol.
> > 
> > A TSM owns an SPDM session and publishes the corresponding evidence through
> > TSM firwmware ABIs. A low level TSM driver is responsible for creating a
> > 'struct device_evidence' context and carrying out refresh_evidence()
> 
> 
> a nit: so it is really refresh_measurements() as it won't refresh the report? may be call it so?

Sure.

> > requests for regenerating measurement transcripts with a nonce.
[..]
> > diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
> > index a6435aba03f9..8bc16029d31e 100644
> > --- a/include/linux/pci-tsm.h
> > +++ b/include/linux/pci-tsm.h
> > @@ -3,7 +3,10 @@
> >   #define __PCI_TSM_H
> >   #include <linux/mutex.h>
> >   #include <linux/pci.h>
> > +#include <linux/rwsem.h>
> 
> then this file is missing extern struct rw_semaphore pci_tsm_rwsem;

This include was a mistake. pci_tsm_rwsem is private to
drivers/pci/tsm/, so I will remove this include. This is the only shared
data structure between drivers/pci/tsm/core.c and
drivers/pci/tsm/evidence.c. It could go go in a
drivers/pci/tsm/private.h, but given just the one declaration have
evidence.c do it directly.

> >   #include <linux/sockptr.h>
> > +#include <linux/tsm.h>
> > +#include <linux/device/evidence.h>
> >   
> >   struct pci_tsm;
> >   struct tsm_dev;
> > @@ -18,6 +21,7 @@ enum pci_tsm_req_scope;
> >    * @devsec_ops: Lock, unlock, and interrogate the security state of the
> >    *		function via the platform TSM (typically virtual function
> >    *		operations).
> > + * @refresh_evidence: Common operation to regenerate attestation objects
> >    *
> >    * This operations are mutually exclusive either a tsm_dev instance
> >    * manages physical link properties or it manages function security
> > @@ -75,6 +79,9 @@ struct pci_tsm_ops {
> >   					struct pci_dev *pdev);
> >   		void (*unlock)(struct pci_tsm *tsm);
> >   	);
> > +
> > +	int (*refresh_evidence)(struct pci_tsm *tsm, const void *nonce,
> > +				size_t nonce_len);
> >   };
> >   
> >   /**
[..]
> > @@ -216,6 +226,10 @@ void pci_tsm_tdi_constructor(struct pci_dev *pdev, struct pci_tdi *tdi,
> >   ssize_t pci_tsm_guest_req(struct pci_dev *pdev, enum pci_tsm_req_scope scope,
> >   			  sockptr_t req_in, size_t in_len, sockptr_t req_out,
> >   			  size_t out_len, u64 *tsm_code);
> > +static inline const struct pci_tsm_ops *to_pci_tsm_ops(struct pci_tsm *tsm)
> > +{
> > +	return tsm->tsm_dev->pci_ops;
> > +}
> >   #else
> >   static inline int pci_tsm_register(struct tsm_dev *tsm_dev)
> >   {
> > diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm/core.c
> > similarity index 99%
> > rename from drivers/pci/tsm.c
> > rename to drivers/pci/tsm/core.c
> 
> This move + related makefile changes + exposing pci_tsm_rwsem are better be in a separate patch. Thanks,

I'll do a prep patch.
