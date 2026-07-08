Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5138C38551A;
	Wed,  8 Jul 2026 23:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783553645; cv=none; b=MN+d/U+YlGJPVrMzdeQl10QbSp6ruIhRmxuaTbz8wxNdHArAC1hyQqO1T35cvdyL7SvmYTQUQNGzAEIbJeRrLmOMmvc6+o6dPOI4YDW7CDMgvuHjXhTnY/QqSfANm9Rt1NGnAw85/mJftUtFBcxcknxJm57DXJBV3WCqNX4ZRKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783553645; c=relaxed/simple;
	bh=ctF3rIqadyAhcePx8DtRe5elaLkLS91IUS/1UxFRjiM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qj9CKfl02lwDagaWmsvbNAjCkW7A0aDKSqXn+D/By9ONkot+6nW2LSfs3lmnMot1sLDMs9Jr2HyEKmLVgL6Rh1flHRsKswLmLJKGs2yYhpjp/Vc8xKa9fHOmG1wp/c30WFaQK6s1OvBLFSsIX3QqvnaAJ1YLElhsrMPPzWMTw0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=B9y1yR8V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pMMV8oj2; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="B9y1yR8V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pMMV8oj2"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 8D57EEC0077;
	Wed,  8 Jul 2026 19:34:01 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 08 Jul 2026 19:34:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1783553641;
	 x=1783640041; bh=DkRTSD8EnZhZyfplamx3kZ7B7vKsKdgiIMwFZ0gbx34=; b=
	B9y1yR8VXWsk8uaMsPNSjriyE1KEV64woJlr70LjZJk9P9nLcMnm5ggfm57gCobA
	Z9hkjq9qlddNSyzJ8xiNIV8De4WawXQyACHkvI8CqheT6iF5f/iKjb2J0ZrMkI86
	MaoE0SC/8mkf+zv/HCDuCOXZTlS1qm6+PM0hs6VhfUAJEbfqOu5/00zBogbzO69s
	QFHn/yWYlIt0j132vaj/Z/4JqWs73TGz+ivOCEuWgz38k+2lyfadqkc3vflMVUaC
	M64/ieoQfvIeBk5glILrrS+h8XEH71zooBdvdHowQPGA1K0E5DnZO7YXaHou5RAh
	VB3D1Xp1xugZvcPZeuRzJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783553641; x=
	1783640041; bh=DkRTSD8EnZhZyfplamx3kZ7B7vKsKdgiIMwFZ0gbx34=; b=p
	MMV8oj2BekDAoQ9N/l1i7nqYr/QtSPbm5nKeXy4o0f56jOAZVR8Pm1KEZ/6Mx5by
	vXuBbrMOsqxT8g+FrvaDJzffSILtuTitipdaH+WZeBJkCDOr0isUUwv1Kj1vPu1d
	OQKPLJQANb+eYJ3lfRGD7+i/UKB1ziWS5440NUKP+7vsTsc+utRh7UyBB6X5nUTB
	JDr33DAZwYDzQSqeCfxa/HqtC/fjm7mjYKMHPDWXEUPgIMwX+93F3iQ0rCI0DAB9
	hiVzRgJb33YiQ3moufec3KzcOK8FfW21pKqYt206rFXIpMZUu3jVhC9FrbDxIpcy
	R+beTINXdVmQdEVGK7Hdg==
X-ME-Sender: <xms:ad5Oar1VrEW4T3CsLbG0etIYp0PeBhySSZgmN8liAm4I3HCn14qTOQ>
    <xme:ad5OavnlLrY1qbccDjt3ZVsb5VkxCovE_y9kIj2nYPvtZdUBECeCwe6EP0W7pIVKh
    rlXDabfxUx7kPxlIBnfab23Cc3JV-DrfKUSOli5WkDX2RV-2dzcAQ>
X-ME-Received: <xmr:ad5Oaq9yIM8bi_rvA91NQu7GXXDkCBismM9iGVQFGvfPCRTrBF7Kp5UJHwA>
X-ME-Proxy-Cause: dmFkZTF7UcUU4Y3WDZRTQWDCK1Byb23HRnJp+Faq1G3D8RtL7hYGl6JFjaGdMXzAICQHA+
    XqcIU6GZsrthOywnQjf1wxVvn4pLS1EXq646WTLg8DOELNUY4w/wQJOKp10J/PZbJUSK4v
    Fx0R4HXnsIh4g6B9RzzhJzwe7PMFO6Vxx203G4GNcRGcjThD6sD8GyRFSV1IrKHpLw2XXx
    /GFEe6JZQ8jywi4eGClo6TvyyXcHYqUqIFdc4zrub7KyT3YnYVzkHoIvsK1a/EuUNFqUPo
    ijwv/0xb+0b/ynjmyMkXG/330YEmG/AW9ulMXS92NurtWcjcsNOTw07hSbFPDObnsjOmfc
    cU1iOxYBXr1czSXqtmGWP7SY2QKxqBfpRQz/K+UjmveoQRrsTnXhQg/Xr8/znLjc6pzNsQ
    asJGSrlwBhDXcXj+xogoVxZvyq1E9radArkAUCcMx9E4DfL3Ymjt1hEzF/GoOXHmdnELbR
    nVeQu/uCJF4zAKBZ2mw2wHeSt5xeKx1LUb8ngx906nYR0KFRRCUOO2KtcAT8trnopVPAwA
    atGwlOmJOgMa/PT105NwqPn3BhHQp7pHoUdpHHxMo+UeY0+fCPtsP9uhshxZy5Y0tt3X69
    CcrDIrk3RzRq6fShLx0FKgheEW9GWl5SwOAHH5Y9XVn9CrYdYY9SU/dA7rhA
X-ME-Proxy: <xmx:ad5OalIcx5wL6hN3mVRrEB7fSXxIixsC-zlvmtMYXOCWT4mtXBWc6g>
    <xmx:ad5Oang5Oy4EiO3zd0H26ldlkQHnxkj_zdh2GhMgdSqOsBP-3YYQhQ>
    <xmx:ad5Oap9paWyDrLSrszQsvoNLAGsvZyMjSYuY1YmHPWccYHgnYO8FaQ>
    <xmx:ad5OakNyyIM1246IR9HPCIktA79iyh-r_y0nRDHJTAyyPibMelL_Ig>
    <xmx:ad5OakPDwX8XsKxdnKISv5KV9e-Bx0vOqfbXJq2LhmV4ybgEafFXYx7B>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 19:34:00 -0400 (EDT)
Date: Wed, 8 Jul 2026 17:32:49 -0600
From: Alex Williamson <alex@shazbot.org>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: <jgg@ziepe.ca>, <helgaas@kernel.org>, <wathsala.vithanage@arm.com>,
 <wei.huang2@amd.com>, <zhipingz@meta.com>, <wangzhou1@hisilicon.com>,
 <wangyushan12@huawei.com>, <liuyonglong@huawei.com>, <kvm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH v19 07/18] PCI/TPH: Add pcie_tph_supported() helper to
 check TPH capability attributes
Message-ID: <20260708173249.2078c2e2@shazbot.org>
In-Reply-To: <20260702124224.57168-8-fengchengwen@huawei.com>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
	<20260702124224.57168-8-fengchengwen@huawei.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Jul 2026 20:42:13 +0800
Chengwen Feng <fengchengwen@huawei.com> wrote:

> Add new helper pcie_tph_supported() with want_ext parameter:
> - want_ext = false: Check if device has valid TPH capability;
> - want_ext = true: Check hardware Extended TPH support.

Ugh, more bool args.  Like 6, I'm not sure why we need to abstract
these structure fields.  Is this trying to create an ABI for external
modules or is it trying to simplify code paths based on whether TPH is
configured.  These could just be macros:

#define pcie_ext_tph_supported(pdev) \
	((pdev)->tph_max_type == PCI_TPH_REQ_EXT_TPH)

#define pcie_std_tph_supported(pdev) \
	((pdev)->tph_max_type >= PCI_TPH_REQ_TPH_ONLY)

With the corresponding (false) in the !CONFIG case, or the caller just
tests the field itself if it's already conditionally compiled.  Thanks,

Alex

 
> This helper is prepared for follow-up VFIO TPH virtualization patches to
> uniformly query basic TPH existence and Extended TPH capability.
> 
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> ---
>  drivers/pci/tph.c       | 19 +++++++++++++++++++
>  include/linux/pci-tph.h |  3 +++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index ea777cc33ae6..c080cf5401a3 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c
> @@ -596,3 +596,22 @@ void pci_tph_init(struct pci_dev *pdev)
>  	save_size = sizeof(u32) + num_entries * sizeof(u16);
>  	pci_add_ext_cap_save_buffer(pdev, PCI_EXT_CAP_ID_TPH, save_size);
>  }
> +
> +/**
> + * pcie_tph_supported - Check TPH capability attribute
> + * @pdev: PCI device to query
> + * @want_ext: false - check TPH cap exists; true - check EXT_TPH support
> + *
> + * Return: true on matched condition, false otherwise
> + */
> +bool pcie_tph_supported(struct pci_dev *pdev, bool want_ext)
> +{
> +	if (!pdev->tph_cap)
> +		return false;
> +
> +	if (!want_ext)
> +		return true;
> +
> +	return pdev->tph_ext_support;
> +}
> +EXPORT_SYMBOL(pcie_tph_supported);
> diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
> index e4f7045fc152..5917a0694c1d 100644
> --- a/include/linux/pci-tph.h
> +++ b/include/linux/pci-tph.h
> @@ -36,6 +36,7 @@ int pcie_enable_tph_explicit(struct pci_dev *pdev, int mode, bool extended);
>  u8 pcie_tph_enabled_req_type(struct pci_dev *pdev);
>  u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
>  u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
> +bool pcie_tph_supported(struct pci_dev *pdev, bool want_ext);
>  #else
>  static inline int pcie_tph_set_st_entry(struct pci_dev *pdev,
>  					unsigned int index, u16 tag)
> @@ -60,6 +61,8 @@ static inline u16 pcie_tph_get_st_table_size(struct pci_dev *pdev)
>  { return 0; }
>  static inline u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
>  { return PCI_TPH_LOC_NONE; }
> +static inline bool pcie_tph_supported(struct pci_dev *pdev, bool want_ext)
> +{ return false; }
>  #endif
>  
>  #endif /* LINUX_PCI_TPH_H */

