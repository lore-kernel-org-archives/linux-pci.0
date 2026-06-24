Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBEB27587D;
	Wed, 24 Jun 2026 02:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782267432; cv=none; b=fP64ZygYOOwpoCeBTMxIOlZZqTwRlaM21pmHwRXDi9GDSNwovemvxYSUnfTLjYo0LcC7row65VyQzS1E6JgLoHx/DeAyMRGqcHv2FkQ+9J/MZ1BTA8CBtm1OUrNb49Cqia3D2z8gge6IZJ4lQ8jbHlEnmyZGjbb0Jly31gJGgX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782267432; c=relaxed/simple;
	bh=t87Y5AfNVJTX7AJ5U2cuCRKmZuys0kysyU2986sEXmY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=IwFC4pVda5B+PC1NdOCNAt63FcLsUoZWk1GR5MdJGmcmIY03KACOSQwz/fqtd1NcK7zi0BgT0BTrZrXXgoBJ6ZjpzcIH+qsW0I2ytAXKWQa9HT6NHy4AGaDYXCLHxfyAaI1nHkg8lJ9DWmNV/HKcgRCOSUGPdhB6UMsiZo0kJzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvJ+rGHx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvJ+rGHx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8106A1F00A3A;
	Wed, 24 Jun 2026 02:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782267431;
	bh=t87Y5AfNVJTX7AJ5U2cuCRKmZuys0kysyU2986sEXmY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=ZvJ+rGHxNTLNpNkN92jxkU3MhcMcNd9gHsHyRi/ags8s9gftyUDeIperuvjNm8F4p
	 E7s/BsooD2ycj/6KRRu4sLEP5BnxysfWs3nHYWwQC9RJKnJdhE0uEm/2lo5dZ7+mx0
	 11BU1CQRc38OP8BxdBv1a6bEdLsh0hJK3Qtb86HZSy0FnkBpBJD3aC+3kuvqqlbGU+
	 S4UP1PnFd4kkB0JJ0rtJ28SPCZHyA5K07iYyqdnAxL9eplTfQmGSsxYwree6LvMvbm
	 xntw8K1hRmWmJPoi15hdPQVttANuQinFdcvcMi5VLii51mT6DNbOLfvbpiaahmWqWD
	 5rsJwB367+lpA==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id DEB3BF4006F;
	Tue, 23 Jun 2026 22:17:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 23 Jun 2026 22:17:09 -0400
X-ME-Sender: <xms:JT47auS_WR2GS_IbU6NT-cDQ5Gz3FNaTJODhK31Xt35WjSpOzf4Gcw>
    <xme:JT47akNTOtvQYB-W-1qO6g3ke0ClEYq1HcTUAUDmb1VppEaQYhrDCcuWHsAMq-imm
    E2K0QMxqdII9OoDVdJNO7JWnWU4grykcpokS_5zx8qcEulh1nbWfH8>
X-ME-Received: <xmr:JT47ahTpJW_6yhi3kGwtfLTc8HIo8OrnznXTc03GHKDxhfqF1b2ThpWb4tNCv-CLb0QQJLYigxqRPVauvciFk2HAgtdEsH2UVdI>
X-ME-Proxy-Cause: dmFkZTGqrVsB3n1qkGtKrQz0EcmuGztuPalH11fEvcGXD2M4B6hJx4KCImmT7t3Obj2MRC
    nkWPx9Qt4BXefftJlPpXf4maJ1ErYB2zYvoc8IvprbHji+T9cXeE7fNYEFkHOMsfXtDEoh
    75vR8o3w3ya6fJK9LzfTohqZgYUxR/o6ZwzjHmpAnUSugDhBTjk1jtKVW2wF/XKNmuhVhl
    /ietFTFYWQ+0/HuVGAczDUQCuc31wHxdp1f5VYHDzcex3SEAj+tqkEHpG41QooHrr4Q1+F
    zMRt01lHRGSyOv4JvgkQDJzbfS8/Ld17SFFw0Ei28HHADrN++kR5OQzzjQJmd/pj79/ONI
    wO5iCbZ/YKi5Gx/bf/vLFvoRS9ejt8EZKcJEHbi4U8uQOylFaOcJ/ky48TUn9vxGRjX5SF
    6wyqUGTtaDW5TTMDDMLZ8zlQsL+10ponoM4a6CU/qk7Jggojg1qwDX2KaimK7guk/8cTpv
    +nvRMnwOJ7LU3gGgAMAfrLMW91KYy9PyQ3scbvbkCt81Z5GoDsj2Wh/3nqTlg5/72BlRKx
    zA+lf7MMPLvUWe1U1yaylROG2fVgqb3apWnWVuokUXuCNKIMG8AH1PYsMnFTI7NEV6N2hq
    QqeHnduvhHtXhbXZ8Bo79fDQaVlQ18juyfFXIROaJrMljjbk8fuxXnKsHe8g
X-ME-Proxy: <xmx:JT47an-MNK9xHEMCXxOsLzrMqJTlrWJ5tRd72X8kdCrjR4FIYFw_Cg>
    <xmx:JT47arVkZW5wOMVVC1GsN2MExY68uvbXYDh72Zz3L9fKXTPgj3igOQ>
    <xmx:JT47alOGS_x_RhUzf6cSuqPESDPMmocPOsEYX7MrF45FI8a1SqxYvA>
    <xmx:JT47areoHHxfwE2A33SrUW0f4pNdaqUIyGeyG8GWxfXb9wn_3NvsQg>
    <xmx:JT47aszmjZiddxeKrN8863SjNkbzP6mh1IyWyz_RXAymgHz2hv64Hbx2>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jun 2026 22:17:09 -0400 (EDT)
Date: Tue, 23 Jun 2026 19:17:08 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: Srirangan Madhavan <smadhavan@nvidia.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Dan Williams <djbw@kernel.org>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Ira Weiny <ira.weiny@intel.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Vishal Verma <vishal.l.verma@intel.com>, 
 linux-cxl@vger.kernel.org, 
 linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: vsethi@nvidia.com, 
 alwilliamson@nvidia.com, 
 Dan Williams <danwilliams@nvidia.com>, 
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>, 
 Vishal Aslot <vaslot@nvidia.com>, 
 Manish Honap <mhonap@nvidia.com>, 
 Jiandi An <jan@nvidia.com>, 
 Richard Cheng <icheng@nvidia.com>, 
 linux-tegra@vger.kernel.org, 
 Srirangan Madhavan <smadhavan@nvidia.com>
Message-ID: <6a3b3e2442710_3c9f100f6@djbw-dev.notmuch>
In-Reply-To: <20260623032453.3404772-5-smadhavan@nvidia.com>
References: <20260623032453.3404772-1-smadhavan@nvidia.com>
 <20260623032453.3404772-5-smadhavan@nvidia.com>
Subject: Re: [PATCH v7 04/11] PCI: Export pci_dev_save_and_disable() and
 pci_dev_restore()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Srirangan Madhavan wrote:
> Export the standard PCI reset save/disable and restore helpers so CXL reset
> can split that lifecycle around CXL-specific sequencing while preserving
> driver reset_prepare/reset_done callbacks and PCI config-state handling.

Part of the motivation for creating drivers/cxl/core/reset.c as a
builtin was to avoid needing to export PCI core functions. So no need
for these exports given no modular consumers.
