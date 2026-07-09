Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D391D32E134;
	Thu,  9 Jul 2026 13:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783604957; cv=none; b=J0ARCyFeqcmsvIoHEhwU8gpLN5DX7gphnD5lK4cTvLHlw8DmHc7KzZbXWUUVzGShMI99SZFT6iQqeXKBnqsIoQ/QytbTH79w8ruit3dx1OjkE/VXv70XlzTYePQojmLMEEQzdiJaxhJNVk7z/NdpookoEp1iLHoJSrvHSk8Kn3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783604957; c=relaxed/simple;
	bh=bExbm5cOSVIVva6s003/uYoMnrEzbohd2KjuN8pGm7U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qxv6sf/2q0cG6G0G+6HBIaugYP9ewDAZFZJpInIUNRedk0UzdwhgCxf6MEqqvZMcIQPynIWfs5P0L81mV4vR/GCafYboYS/dac3OXTbOc3ZmK9WzlxUekuNmfI09H1Ji2/RNEPNC0WHDGYAvPTp1WMZJYLCumDYy9aHgXujXNs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=JV3isjlE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VOGHfRjz; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="JV3isjlE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VOGHfRjz"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id C46351D00075;
	Thu,  9 Jul 2026 09:49:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 09 Jul 2026 09:49:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1783604953;
	 x=1783691353; bh=ywchz12tmLYB+DYGe+Q27Ca82kjf5533jZt9UUozc3w=; b=
	JV3isjlEw+RTRJiB5rKnMGpiAMivf1AiB8Lve/II/zaDViD9JEbRkf68DAC7PJDI
	Laqw9HhNPx4jsCXewVYf0ibJERSDL+EmhbyMEu72ll6SOZtPnpMapjAWfFcfzJjh
	YibzagS9BmUBB/vpbE1K6om3zzUkCeN/D48/gDPtPHwkgFJGukA9/1VdX2sXeZpj
	k+Ksk6pmbSfF8VI44SWGY67DSgg2WmVV7ZAV1CQi+wdUbIxHe8/t+R8jrbExPAr4
	fmKTUeKTBilLNQcbO+WXHalG+KMaQOZ+VWdKMVvONy8K/Fr8LuI3xBRdHNKQBJjW
	1QXh/u+PH448+oXI4VRzdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783604953; x=
	1783691353; bh=ywchz12tmLYB+DYGe+Q27Ca82kjf5533jZt9UUozc3w=; b=V
	OGHfRjzDKAwPEUgGuEL3p7AOx3UUrY4JFEegr1hrm6WDcgA+wXe3zfuChSCoHJ+m
	+VPzn+qgxqzSwL42SmTZrtEGeaOoGb/2NR3cn50e1zwiYGKswjtzvp9kTAEI9NOX
	OUxZbdORFnxmBo/TS8nTi/VCOSJoDmCAQoNyyeH8dgm/oeDGjePwhOjqtE9Hz0wp
	wuuJTYHT9Bayjh9dGo2Xtt9GI2s9PyFqhwyR8BbbWFlGiD/or5tm/wjxMHBlf/Ja
	84YK1oSMxDJAHu0Xj8e1D5phdyb48GaZ5b8QUQP7KWXB1F1bS5niHAXZiuGKsLyJ
	4NBu0Dq0jHD78QwmK1iKA==
X-ME-Sender: <xms:2KZPavd7PkjtElP6Q5RYQ9brjo8aOgM5qMTOxmba3cSGMnEd84na7Q>
    <xme:2KZPamzvXJKXWl3KouqxczQMYZEXyQlWle7jyrxKDU5lH73JmaG3yRqRBkIaIrwqX
    LkVi3h076XJWxvzGUGcxNR1eulPvPEyRWUz6OPG4X5Ml8SojCYH>
X-ME-Received: <xmr:2KZPanyPx3Zsk86-v4VGhG5NNHIicVzK5kcb9j4csJEX81r3XnL_G3buSNI>
X-ME-Proxy-Cause: dmFkZTGwhSBG68YwJuoNZJfo2IQpi5EaHwc6DvZr4pX3CphkxZFaTD4+1fsPx0PEdATAnq
    RS1P8A7BE7VEeDC+L2kbnZNqhaltsUf+U07O6wqqzH+xBedcOYEGgzTwSfxlL2aXQVgvM9
    Z6GAfxZoXOaEkxbZEOkKnikIWTKT1RaUw0lFehLAOaQtNXRLht8KaM+NBjrTt5pOTBTRrk
    lbrdq3AiA7sx3+QaHtAcoWF3NKY9ZU9o6/EjsCwm2PYLRQcuAcL/h/WKF7yKGQDX0FCJ3h
    MJ97g1i9RXX7usCxh6fa/AoLO/ZAJWO62xSE2mPAeGsKupkJ4yydg8RegTVIIBlF2A6enQ
    HuPXF6GCFUWNJTF5KzBA7ISfsC64kBDwq8i+6zaIMmHnkbk6zMsUI0UfJj3DnQ8Gqv+3Fv
    Ll6x9f2bonXZ2QSOD8CxZOPwOk7Wfa32ps4BugDabZ24BS8Xuset4IyXR1XPW7M4XaJ+TV
    x3QhElE+Rh/48k2JUXSrZ7mVS7+GBq1RiXm6WhAiPMFFl/0Tpgh2f1vrrUoluRS0v2Zbf+
    SJI5fQES4LHhLWQgVtA9tcWR7mdaFVKmLzvQOyVQHAMutVzOHFScKmVaEuF7LdiuW6KHaE
    OdzSBESM0P9AAkH2Iyw3upGzPqEm1fwBHhBPHmLtLMSsC1nJ58SCGCDPMiIw
X-ME-Proxy: <xmx:2KZPanZRMNfJuAlNXQK1teZOFURM6HrWJI3ZWZ_-nbMlLtBFPs56Yg>
    <xmx:2KZPag3BIz-McyEjNxomOjqdz0PFzwdHcBDxv5uEJnVBQowrM5h3cQ>
    <xmx:2KZPahdfEZJPKHcPdHtfs6DQYRxaDFyvk_ZI7IdmUKpPUBAmXkqm7w>
    <xmx:2KZPalJI-OSUdfSgogtDUVQ1W_vn3c5odFyxKwCLJtmAPBwqVuLWyw>
    <xmx:2aZPavgk0teZSQ_SHtYfhE5hXC9a8IbHEs5NeRg01IQk7gWXVm1T0hLJ>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jul 2026 09:49:11 -0400 (EDT)
Date: Thu, 9 Jul 2026 07:49:09 -0600
From: Alex Williamson <alex@shazbot.org>
To: fengchengwen <fengchengwen@huawei.com>
Cc: <jgg@ziepe.ca>, <helgaas@kernel.org>, <wathsala.vithanage@arm.com>,
 <wei.huang2@amd.com>, <zhipingz@meta.com>, <wangzhou1@hisilicon.com>,
 <wangyushan12@huawei.com>, <liuyonglong@huawei.com>, <kvm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH v19 16/18] vfio/pci: Implement TPH_ST feature for batch
 ST table programming
Message-ID: <20260709074909.67ec173a@shazbot.org>
In-Reply-To: <b3c5827c-c16e-4cd1-bf13-2ed0220716ba@huawei.com>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
	<20260702124224.57168-17-fengchengwen@huawei.com>
	<20260708172954.14bff5c4@shazbot.org>
	<b3c5827c-c16e-4cd1-bf13-2ed0220716ba@huawei.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 Jul 2026 20:36:05 +0800
fengchengwen <fengchengwen@huawei.com> wrote:
> On 7/9/2026 7:29 AM, Alex Williamson wrote:
> > On Thu, 2 Jul 2026 20:42:22 +0800
> > Chengwen Feng <fengchengwen@huawei.com> wrote:  
> >> +
> >> +	if (copy_from_user(&tph_st, arg, sizeof(tph_st)))
> >> +		return -EFAULT;
> >> +  
> > 
> > MUST validate undefined flags are zero.  
> 
> The following "if (!(tph_st.flags & permit_flags)" check the undefined flags bit.

That only tests that something is set in the permitted flags.  Thanks,

Alex

