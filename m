Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3375477E;
	Thu, 27 Aug 2026 22:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787870635; cv=none; b=i66RgaNtn7hM1GoY2xVydt7Xz6zH45BlJXl6G0AMQhNk1A8huObtzAYmk6E4zcCFY9ZZtMzBJcfunQ8pPp28rCpyRzmF1h+C/6/V31t+OqLjVtY/d0JFa6fpIP0vfhlg+dDGLMJ12bpeD7ieqRCJuGpLx/HB8uw8i9amTJ6GZW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787870635; c=relaxed/simple;
	bh=Gss/cDQ8H+W7DQDN2aDMcxFdFXy+TXHeIF4iShN9GkM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oWBXNOA6hcfAc7g/yVBOe5QvFI8XO4PwBSajE/hlIes5vCYU53TJ6Q1LGDPozf/ZB6VtaooY9NLHult9qZGeIxrhPNVrIhx7y2U4xJtCcS76k6gb32X5WUPTAL0Ur/TYxY48ORuWDouN76mbNVUFAFAblqGDMaueC7pcjbQ43+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=SzrRT5Xi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KvuPmX7M; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="SzrRT5Xi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KvuPmX7M"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 45B297A013C;
	Thu, 27 Aug 2026 18:43:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 27 Aug 2026 18:43:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1787870631;
	 x=1787957031; bh=546rJvPJ+CtqaeHiXpNfIu9/aonQSvj7gIpitDcXz4g=; b=
	SzrRT5XicKJygkMOEH/wTgHIyfnXjP2bgVPMzJ4bZ3EcTVS/oVRuB8KApacbH3TS
	XxOAeC1mN+SeymxueEmyqm+//+bj7NB7e5J60NiapuSSctvo3t5Xw//PpqX3P08d
	EteAtTAUsBkfkFKV/pW+s2ctkODVWjhzwg4X7bOXwetlqU63hFRftciJG/g9qZxr
	u392F4WylXIBOHoxgSVSeCXd+npWJknW72367y+nE5mWL2VyZp2fW3C5TaCFMXEM
	md/VVaysw9jL+B36nWSFHQoGUC34fjcrdbpPjQzBAJkzfdD+fdhm9SyHRvRT/TtS
	vg38ZPpm8sXdKHQ7kFDZBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787870631; x=
	1787957031; bh=546rJvPJ+CtqaeHiXpNfIu9/aonQSvj7gIpitDcXz4g=; b=K
	vuPmX7MPXK5hBq3E9nT9JBKjydsn6FXmcd7q1J1V3tZ5IhyKpVGUP4GFJBdvk7iw
	mmx0+EgZTGRL/XFVWtCb/yxCDrxVbAgbFM9YXoprQ/67+ukCS6A/PaeUmmmok5I4
	gyGqoeS+nlne/FvsCe8OeqrDRuJc4SSb2G5S9kiezZd4qXESaUXlXkUrTea1TTy3
	ExHaQkqj0mAiHv43iAbfpBsY5eHexZdPC9u6AjMsmHOeqaxs9/r8fl6WnL1f7eo9
	wXg+oKyeUeT0rB70Deet7B8ogd5qyUc/tlyrNhukDMX2dFLDNnLgnSau+DrxQ4U4
	qqEeb948U4en3ufxzJ95A==
X-ME-Sender: <xms:pr2QakmCDF0HdQT_TC7NOuOSgdcKCkUQWZsy63xmXxaB4eB-BUtogA>
    <xme:pr2QahfKTJLk13wVUi3PZJ6egBjWzTY7T6Bc6txFYsLuJA_oDVyAw09Bh97ZJJ4mQ
    5VkhQkl_UhVBYDWsACK9ip9XXiM5ztzmeOzlsK6bIC6pLbXVr7ooA>
X-ME-Received: <xmr:pr2QaqBHr1aZwyZ-2YHGpsSecuIrQ8vbw-eTTpSZNoKHY_ecDMihDVhTBo8YHQ>
X-ME-Proxy-Cause: dmFkZTEGubksZBOSpJxpM/F6lL3zmc8LtBWhTxIj2jTHFGVCJmm4hQyEEnrzL1ddf/UU0i
    S3tXSg7bioNcuffF8TdAdK42qaY0QSoP49ebonNvr0oKKBG8o5uOUDOzEn5lcBtEqjn0f9
    CIRekXsSAC0EIiPc3DOI9tTVnmosPKY7+dNFbbOgDk8lNEjy9CrzVW/SVYlLsv2Yttusfq
    GJwsSz1mlMmDoVIR6ljpWq3Y9i3dDMqJAqzsvIaTvgJ9gngTw5/y+SaUQzbK/kGLvDJToT
    eOpqoIK/rJ3fWPNDUFREnpG/WAtzIsq1tMjtTbtnZR+jex9Lgv5MpCKK9CecyU1cN5dpHX
    Jd2LhL2kzquj8hB0rxUZHf7GMzg9+DKeJDWyN15nPeOR0wFPS5jqtTRZgR1UrG+Ait1EIp
    fYsOOrFsf9rYEoBPWFWSuakND1UHkI6vxXKpR//ewn38STNvWY2Pl5L0cZqFEedzYG5+QP
    sOFfDYqyK3MtMfq5sLUhee7IP645zUgvdfD7m3keA++LHXP47VBAYJAFf2xJFGDAaIwlCd
    /4SolZZoLcQ2IvUmo9DA27jIFT/EAghUfsnErdA7qLu9ex2SpQ1W23UucZtV4gW/+CL+b6
    3km/m6H0tg+vlART/R57MTE77RW7JPHwcXKU/Z1TIBplqq9QBcAWaMTktJKQ
X-ME-Proxy: <xmx:pr2QaowLo_yvBIESG-ONvDgJoUC6DCPiTKIB0YaIf9OUjJusA6A9zg>
    <xmx:pr2QaqhqwyR05gIfl6x_fqGkaJP8GcDqu7wj6mOZSiWojGUOvpLzXw>
    <xmx:pr2Qanfadh8WFpknT5Xo7Z9E3Dli13Qt0jQ1Bchb8yUlVbYTRqbi_Q>
    <xmx:pr2QapU5dNDX_VITh5Z7v7HeTquSJJAAGNhTKiAI0D4l6QGL3oGI3g>
    <xmx:p72QajyPzlwo52v_kuQrIKgFKkhytVIQT1oxE_sln7yWu2vYCOWEdczu>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Aug 2026 18:43:48 -0400 (EDT)
Date: Thu, 27 Aug 2026 16:43:47 -0600
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
Subject: Re: [PATCH v4 14/27] vfio: Add CXL region type for the HDM region
Message-ID: <20260827164347.02d7e871@shazbot.org>
In-Reply-To: <20260813093631.2288172-15-mhonap@nvidia.com>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
	<20260813093631.2288172-15-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 15:06:18 +0530
<mhonap@nvidia.com> wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> A CXL Type-2 device exposes its HDM memory to the guest as a dedicated
> VFIO region rather than a PCI BAR. Add a CXL region type and a memory
> sub-type for it; vfio-cxl registers the window under these so userspace
> can discover and map it.
> 
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  include/uapi/linux/vfio.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 5de618a3a5ee..540e62312671 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -345,6 +345,7 @@ struct vfio_region_info_cap_type {
>  #define VFIO_REGION_TYPE_GFX                    (1)
>  #define VFIO_REGION_TYPE_CCW			(2)
>  #define VFIO_REGION_TYPE_MIGRATION_DEPRECATED   (3)
> +#define VFIO_REGION_TYPE_CXL			(4)
>  
>  /* sub-types for VFIO_REGION_TYPE_PCI_* */
>  
> @@ -373,6 +374,10 @@ struct vfio_region_info_cap_type {
>  /* sub-types for VFIO_REGION_TYPE_GFX */
>  #define VFIO_REGION_SUBTYPE_GFX_EDID            (1)
>  
> +/* sub-types for VFIO_REGION_TYPE_CXL */
> +/* CXL.mem HDM region of a Type-2 device, mmap-able */
> +#define VFIO_REGION_SUBTYPE_CXL_MEM		(1)
> +
>  /**
>   * struct vfio_region_gfx_edid - EDID region layout.
>   *

CXL has a PCI vendor ID, it's even used in the dvsec capability.  Why
not use a PCI vendor type region?  Thanks,

Alex
