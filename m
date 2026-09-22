Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7ED38D686;
	Tue, 22 Sep 2026 02:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790043371; cv=none; b=MBF9i9mtRtdMBxU1ChOoOa2IqTQfWJ/KHRZf6rL3T6HRxDTM+fCca+Z4pvSG9Zos0NBXjnEEFFcAFrpEEi6ClatZwjK+lm0BoMabYPy4nm5oL1BUPg3F7srQi7KzKcF3ffq+nlxnP6D6BcMBF2QLXjUArlwE0N5B/UuEFOUbwA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790043371; c=relaxed/simple;
	bh=CoKIBeZmJ7QA1d9aPo4CfntHujNXu76WX/AudvcV5LQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ebyeE8VutbwYZ6uBp3vdqKiKxTEFM/S3bSU5B77BXXH2QtN/zTlLdqY5kq1FucnNuQLFzIV2f6/qnCsH5mNM9z6s3epNB+2M+wc3F2cppy/sgVbAqKVHMZui+nLIOeCcgOyyth6eF/qMBX8xqAXiW4fLevzLDN1XqSY31hFkU68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=isUO12VF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bGx7vRM6; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="isUO12VF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bGx7vRM6"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 05A9B1D0006E;
	Mon, 21 Sep 2026 22:16:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 21 Sep 2026 22:16:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790043367;
	 x=1790129767; bh=VUgKKRMsqRSY8YzL4ANWylJ1J7urLhYIfCY0ZoTzhR8=; b=
	isUO12VFk03l5dKjOyJSe1/kfOLWeYRQPde3bgVkVFxLqXq3blWe1V3V2w3REvG+
	EPC5yFDz9slZCRqP32Z9XIcjt7aA269UFkUbggFtoNEiRSODPLAZtQGaEnMPedAt
	+/u4wd2TygQTbDUYfeTSsBpcFMitV5xEOsE8RbN+QkATo/HCcBaK8A9DO1UD8uEz
	pXZv+zpgDdj0nTlCF9bfjrMn1ayo/1aqoWFN19GMU0ZS/wOIYRmvuTkhrhgX3iAe
	bpxUZz+3PvlW0Mu4dIw45zCt8CcSLR2b8zpX7kNyQKfn1zyJRwR59OI14sbrOyLA
	7Hm75HaIz9YjPCrcutLKsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790043367; x=
	1790129767; bh=VUgKKRMsqRSY8YzL4ANWylJ1J7urLhYIfCY0ZoTzhR8=; b=b
	Gx7vRM6LA8Vn9oiAq7HvN43v9MCfFTONx3DHFS1QDeh75U7es0yxP6F/T1lO0+W5
	JGuKaDG6GB+yP1q+8OD4crZ5eIIM+4TXzsIcQpcphNfH+wc+ZA3e8U/X1DvMO6+z
	cakjwG4Xy6hoHtnSIurS5FrHVXW94TGQv6zkZjJzflRE2/neZ8Gd9Hz1vXc/IVs/
	vEOLCJLIADMgCo0wS8rBb0vZiqiWBslhneprmcRKB1k8srOV0luRYRY23rY/wn7d
	HM/5GcY5zv8cH1vw2R+ZR60mXj2I7z+UWGIhUdpZUdzGAM++yIkVWY1DHTrfcqq6
	+7Cw3bBg5dtz0w/ytluoA==
X-ME-Sender: <xms:5-SxauniQExTWNe3b7c67V3XWO8Hb6zzK423a3EgXNsFAB01RLN-Vg>
    <xme:5-SxagqFgs_VUzxNePHdrkrApczdrdSv8T6cKjITwISpOHUum1Fmw8eA6DMYc8NT8
    8mwIWJuvJ8jn2AbA1KkwsAxj1vkm6TXwA70e0iL7OTmwI-E1h4qLg>
X-ME-Received: <xmr:5-Sxaq5tecG1l3f85hm7cnTmL5Xt_Nl5HmjzbpwyPuYWFODX6Ds4_HmCB6ESYg>
X-ME-Proxy-Cause: dmFkZTGXJSHqMq/BnZYJ0YweOb4rS2VUXpPM7d5+lSYGhnppGFsNjl5Bysv+w6+cDnCJ/7
    /L3Cxi42gIwxQ2NUo+88ApQMAdaEv47yc8fAsLypxGx87oHF4HT7ama3q0ueulG4TPc0DY
    g9aq/+AIZ/88RBFY6z24OfxBW3WPjyGYAaKrF0WRpWdqsttcvGMxliaYSaCPsYHObnA4na
    kPveiLHd3CCXxarYrwtQo6T70Ls9xKt0FRJqIrLM1i8XMnEKMgqeJVG7tIy0ld86sgmRqY
    QTP1Xf0Z/CD0h9dlYVSVFIdwBL83CGpVR9ekjjvy4BxnnVieSYFxqs3RHn4BnowjRSHsXC
    tV2+mVQk3+Z8nBxdBvb6qbyGPzPDnfmdNs/xdijFopo4M+DwgAmljv9e26ug8MlZMuZkht
    +kbz+YDXa7rfgR2Tah0F9L6yp8oC/lpVWJgr4BNMpU7taWPwdpkdbSgcE/vR6ABtSZL3q7
    eKGsUrbQ4z6RKj/hVlsQI3P5QD1AtMu5deHFpOr5Uhv6eOs6Yf4LCYiZrneF09ItPdSjJI
    NKpzGFaHPFaYAfEfrd6uKNgotitdrWSVMXqtMmOhmWL4cMMmhXJ1s7D36mHm0HTZh23hr+
    kYuUNRGivyFEJewfpNlVOkHDWN5i7e8L7NwWcTVUcpC7B0j0EWbSxJ/y/XhA
X-ME-Proxy: <xmx:5-SxaiK_jYPWAdE18liHTGJbrKbzWGdNshq4TDYSl2lkM8NWuddSLQ>
    <xmx:5-Sxamlu-u8zjgaIoijQGm69ZhaC5-9wkeZDTdv3uV5sOpnX7vs6ZQ>
    <xmx:5-Sxap-jfQ7bDa5vTOodFAVpMrYu39WXug38d_FqW20eZj7WrhYQyA>
    <xmx:5-Sxat6gaIIt9jqsvzDMT98ZbmrZlUMohA-k7wtRrJDty6hfFIGv4A>
    <xmx:5-SxagWhAKgwqy4z4H4h8UwtkpkmtZjth4LFcHTXedC_HitL8BJJB5v5>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Sep 2026 22:16:00 -0400 (EDT)
Date: Mon, 21 Sep 2026 20:14:43 -0600
From: Alex Williamson <alex@shazbot.org>
To: <mhonap@nvidia.com>
Cc: <jgg@ziepe.ca>, <ankita@nvidia.com>, <jic23@kernel.org>,
 <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
 <smadhavan@nvidia.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
 <dave@stgolabs.net>, <alison.schofield@intel.com>,
 <vishal.l.verma@intel.com>, <iweiny@kernel.org>, <ming.li@zohomail.com>,
 <yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
 <bhelgaas@google.com>, <dmatlack@google.com>, <kees@kernel.org>,
 <gustavoars@kernel.org>, <cjia@nvidia.com>, <kjaju@nvidia.com>,
 <vsethi@nvidia.com>, <zhiw@nvidia.com>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
 <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
 alex@shazbot.org
Subject: Re: [PATCH v5 11/27] vfio/pci: Virtualize the CXL DVSEC in
 vfio_pci_config.c
Message-ID: <20260921201443.04eade30@shazbot.org>
In-Reply-To: <20260916183540.3813685-12-mhonap@nvidia.com>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
	<20260916183540.3813685-12-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 00:05:24 +0530
<mhonap@nvidia.com> wrote:
> +/* Virtualize the CXL DVSEC so a guest cannot reprogram the device through it. */
> +static int vfio_cxl_dvsec_init(struct vfio_pci_core_device *vdev)
> +{
> +	struct pci_dev *pdev = vdev->pdev;
> +	u32 dword;
> +	u16 dvsec;
> +	int len, ret;
> +
> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					  PCI_DVSEC_CXL_DEVICE);
> +	if (!dvsec)
> +		return 0;
> +
> +	ret = pci_read_config_dword(pdev, dvsec + PCI_DVSEC_HEADER1, &dword);
> +	if (ret)
> +		return pcibios_err_to_errno(ret);
> +	len = PCI_DVSEC_HEADER1_LEN(dword);
> +
> +	/*
> +	 * The virtualization writes fixed DVSEC offsets up to Status2 (the reset
> +	 * doorbell stamps it). A device that reports a shorter DVSEC is not a
> +	 * usable Type-2 function; leave it as plain vfio-pci rather than index the
> +	 * device-length-sized perm allocation past its end.
> +	 */
> +	if (len < PCI_DVSEC_CXL_STATUS2 + 2)
> +		return 0;
> +
> +	vdev->cxl_perm = kmalloc_obj(struct perm_bits, GFP_KERNEL_ACCOUNT);
> +	if (!vdev->cxl_perm)
> +		return -ENOMEM;
> +
> +	ret = init_cxl_dvsec_perm(vdev->cxl_perm, len);
> +	if (ret) {
> +		kfree(vdev->cxl_perm);
> +		vdev->cxl_perm = NULL;
> +		return ret;
> +	}
> +
> +	vdev->cxl_dvsec = dvsec;
> +	vdev->cxl_dvsec_len = len;

cxl_dvsec_len is never used here or elsewhere in the series.  Thanks,

Alex

> +
> +	return 0;
> +}
> +
