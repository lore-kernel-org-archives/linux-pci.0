Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C2B37FF5F;
	Fri,  6 Mar 2026 23:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772840096; cv=none; b=aj+REjqxfF+bfbZc5vPC7LTCaxJFfZdLL0w2moGITVHfbVmDm3HI4yLNVCAQ7m5sx3TSoHpDth9u835OKAbPPh0lUIDMjhiJZJY46cSv8ADPbDXqCRcwB1LUdxHtPex5du8/8ZJojZ/jOQm1hHbgwc/9Jg8o+a6O4HB76yoAKw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772840096; c=relaxed/simple;
	bh=+Nn+a6+USCFLxl/fhcNP7z1aj2yrT7w1rIFzYWNVurk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UYUt5bpA1jojvR3DBsGi2IQkIjEPgpph2gZYtzDEEue05m1iS/tjNvTBUwbbUQ89rVjG/40LU0wlKtmkxud2p6KP4fDBI0va0/4yvfAqo/SrC8WmId/OysNg1410zCIeP3Pd1qZLfJXL47WGixDILKbvsoOmNNOFDAh5sl04R/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=bU+iOMRf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zCH0rVE0; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="bU+iOMRf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zCH0rVE0"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 534801D0018A;
	Fri,  6 Mar 2026 18:34:53 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 06 Mar 2026 18:34:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772840093;
	 x=1772926493; bh=4vfwFB112SdNZkOEw9yoeJTK3rSAuPpVVgpDDEPwBvA=; b=
	bU+iOMRfrwip4XXVey1QyBBEDS1MeT+vmssZOydgvIzxGOhBRifB1VjqwQ1kHWlr
	wbYMxz6Gr20LxL0QQDegUjEqPb/5StyVC8ll1HfRoQ2tULomIHSApZ+aW7wkxFJB
	5byl2urqBrAjXRPLeYCSj/RpbNcPxt0fN5ZLXM4SKAB/h5j8z8BuAqTioyqziA/C
	2bQwmizsG1LluqWJ4fX4ROOGnuuwZQkSaEMb/jgYh1yQqi6JgfcR6TrwRZHvVe3j
	y2Ocrvz2iWxO06KTgUnZU4jAJBVjOUF7GYXS28hpixWzV5j01NjK23A4/waxbkwd
	YlYJ/cjwyMWsxCB7GFMD/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772840093; x=
	1772926493; bh=4vfwFB112SdNZkOEw9yoeJTK3rSAuPpVVgpDDEPwBvA=; b=z
	CH0rVE0Surx9e3d1k1pooFhKp+ESoDv20NxaASP7kMBQRkEELAcYpuJ96Ch2Xb00
	Tm5gB0GHh7IH2rL0P7q51t+fEbFjWSCRIicZ+CNDswcW6gkBRpjM0bHnuaSFecQO
	2cZuuIrJtZNco6OaXyqq8gyOsONP0vY8KDpWoMOYkMBsh91Is1JFpfMaARkRhOjf
	FUCV81lDJdrVNdz31xWH6PU9DsPJB/3ymwvQn+qNPaOJkB6HQmlSlNRqZITb5YHA
	TjVEp4T0hmBs2RVXQpzjawZfVBZmCfZQMIPHFM8TEGkdwVV/4n8rkzY0cTWl8yrj
	u4T5yYOflkEkUgey6PPEQ==
X-ME-Sender: <xms:nGSraT4Xestez8xE2GRdlrzvUkUxnkFcp2rNIM2psdmrY-niYwrFIQ>
    <xme:nGSraaigzpqksQrqVBRVktYZMZrk-vxJ3iiWNmITPO4dF87GEEKHJ-ZUIEzimzXuS
    Odr9Tr6XuwrrFndngZdc_lg-8kyyfu6VEU-5Hhk3DTTMSQGgPT8Ng>
X-ME-Received: <xmr:nGSraeg887_0_JK6ZFO7uDWEgTuoC_pwiRIKyyCZSzOO80jzArVgJ-EwZao>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedtieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgoufhushhpvggtthffohhmrghinhculdegledmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpeevveekjedvtddtteejffffvddugfeljefhgfefudehgeeihefhkeeugeff
    vefhteenucffohhmrghinheptgiglhdrihhonecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohhtrdhorhhgpdhnsggp
    rhgtphhtthhopedvfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlvgigse
    hshhgriigsohhtrdhorhhgpdhrtghpthhtohepshhmrgguhhgrvhgrnhesnhhvihguihgr
    rdgtohhmpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdprhgtph
    htthhopegurghnrdhjrdifihhllhhirghmshesihhnthgvlhdrtghomhdprhgtphhtthho
    pegurghvvgdrjhhirghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehjohhnrghthh
    grnhdrtggrmhgvrhhonheshhhurgifvghirdgtohhmpdhrtghpthhtohepihhrrgdrfigv
    ihhnhiesihhnthgvlhdrtghomhdprhgtphhtthhopehvihhshhgrlhdrlhdrvhgvrhhmrg
    esihhnthgvlhdrtghomhdprhgtphhtthhopegrlhhishhonhdrshgthhhofhhivghluges
    ihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:nWSraakFO1-BjgNs7qmlPcjRBirfAMf4_KXkujSk00lSBwJXI6K-UA>
    <xmx:nWSraWHb_SZIspfI3Idkqk9Q2cJ9LI7d_EJQvnX3AZsUjHVd_Q4-cA>
    <xmx:nWSracOB7Ap6GMDlL9bEYtY-BbFTkyAxolHbpogPE3nZlYVzVwo1cg>
    <xmx:nWSraduCODVRCJTDzKwBPsY1v2kzNXKubo0uKZJ6OylQB7_Y66ipaQ>
    <xmx:nWSraayhRdTcuhtZwHeZfEHpH3liNDwgNzrAaYV33XwsUsaUv0FzgoYU>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Mar 2026 18:34:51 -0500 (EST)
Date: Fri, 6 Mar 2026 16:32:32 -0700
From: Alex Williamson <alex@shazbot.org>
To: <smadhavan@nvidia.com>
Cc: alex@shazbot.org, <bhelgaas@google.com>, <dan.j.williams@intel.com>,
 <dave.jiang@intel.com>, <jonathan.cameron@huawei.com>,
 <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
 <alison.schofield@intel.com>, <dave@stgolabs.net>, <jeshuas@nvidia.com>,
 <vsethi@nvidia.com>, <skancherla@nvidia.com>, <vaslot@nvidia.com>,
 <sdonthineni@nvidia.com>, <mhonap@nvidia.com>, <vidyas@nvidia.com>,
 <jan@nvidia.com>, <mochs@nvidia.com>, <dschumacher@nvidia.com>,
 <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 7/7] Documentation: ABI: Add CXL PCI cxl_reset sysfs
 attribute
Message-ID: <20260306163232.0b9f75a4@shazbot.org>
In-Reply-To: <20260306092322.148765-8-smadhavan@nvidia.com>
References: <20260306092322.148765-1-smadhavan@nvidia.com>
	<20260306092322.148765-8-smadhavan@nvidia.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Mar 2026 09:23:22 +0000
<smadhavan@nvidia.com> wrote:

> From: Srirangan Madhavan <smadhavan@nvidia.com>
> 
> Document the cxl_reset sysfs attribute added to PCI devices that
> support CXL Reset.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-pci | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index b767db2c52cb..d67c733626b8 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -174,6 +174,28 @@ Description:
>  		similiar to writing 1 to their individual "reset" file, so use
>  		with caution.
> 
> +What:		/sys/bus/pci/devices/.../cxl_reset
> +Date:		February 2026
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		This attribute is only visible when the device advertises
> +		CXL Reset Capable in the CXL DVSEC Capability register
> +		(CXL r3.2, section 8.1.3).
> +
> +		Writing 1 to this file triggers a CXL device reset which
> +		affects CXL.cache and CXL.mem state on all CXL functions
> +		(i.e. those not listed in the Non-CXL Function Map DVSEC,
> +		section 8.1.4), not just CXL.io/PCIe state.  This is
> +		separate from the standard PCI reset interface because CXL
> +		Reset has different scope.
> +
> +		The reset will fail with -EBUSY if any CXL regions using this
> +		device have drivers bound.  Active regions are torn down as
> +		part of the reset sequence.

There's no such test afaict.  Thanks,

Alex

> +
> +		This attribute is registered by the CXL core when a CXL device
> +		is discovered, independent of which driver binds the PCI device.
> +
>  What:		/sys/bus/pci/devices/.../vpd
>  Date:		February 2008
>  Contact:	Ben Hutchings <bwh@kernel.org>
> --
> 2.43.0
> 
> 

