Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB394AEEF;
	Wed,  8 Jul 2026 18:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783533998; cv=none; b=NVEu3wLkDqBonviwjjVM6H9D/dAzMAgFIR6PzoC8EZSQqI8tgYW3sOJg7M2OgoYjQAKlWHsnFdXnr7uuNPGjVsEJX/V9B5bcG8kMEq0d3/iUeseBvvITjPFgiWEj17Nv7/7JNuGWSoQyan6yRO/xJRyGX7p/vC5txy9VrFLPSb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783533998; c=relaxed/simple;
	bh=Oa2BgYR8p8J06J2CdAq4o9rpa8EQ7psgZWmJebbFaoA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=GAtOoB7LAIWKaNGopTmgGgn8cPqOJDHmReOY2eb30G7/4X3D/kBxM2csXpg1LhajECo3rqlYLUAKP08oXp36knbAqi6C5cjAMTRl/CyrQ95ujhSiIfcLEtmRTWnfYmgIjGCo74dDfJWbbrPd2gccEHamA5jur1HAp+I/uQRNsl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+3ODdbP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+3ODdbP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3241F00A3D;
	Wed,  8 Jul 2026 18:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783533996;
	bh=e0bFWsoaqBv2djOOlnZdWm5zb8G3aS5btuW4up1P41A=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=W+3ODdbPDuGRTkNP5KC0F+5VFcTCVTEPhAeawWiKxVntkCFtl8eOlTuKAYGxDJ16o
	 fqqShGPfyVQPE9JI+TORr/rTbg9cQiVGnZIqDVjG8tN1h97AefQdokwz7WAzrzKOZQ
	 mrSLeRIu1ERbT1YMbYRrgN1Toy+hmeOkpwiPNM3zf+7hmI3KX10ncfjFjs/VmgRZWp
	 agDWyoN3JfYxhxZQWmQlbrQQYVOjOScIcdfDTeobfanXz5vLcMcHHAHe2q8aR9zih2
	 xRlUdlvmnBOeBuJTTrua6y+IO/CESwx2JuQlGTu1wqQc5bfY2lhaUIglZxM3RC6w03
	 EqMrRl+4gkgag==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8D4E7F40068;
	Wed,  8 Jul 2026 14:06:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 08 Jul 2026 14:06:35 -0400
X-ME-Sender: <xms:q5FOalhh1orq6-qZ_RZplOnJSK2_2AAYvIS3LIT5jRwGBBHM0s9oNQ>
    <xme:q5FOal5Vwbz9VPX5FT3xwQvJPsWFv8M11J3u6KLQqlCjJSftX0WYXhaC1A3a8Enpx
    ius2dg3PVwdm19XtyYEbqeG8RIoesLK_NuAqpcJGo10V5L2x8C_JDA>
X-ME-Received: <xmr:q5FOaiHodhf3mH2Owf_uv8kTnOS0BP8X1ykGV6qQemoeDLQ59gkCYsoi5MVywhLCJkfjLdb0_i-oqvsd5utHJn68k9vq9k2Y-Vo>
X-ME-Proxy-Cause: dmFkZTECx5uQt0C51BhO/KdCXtZS9QBkRtRmI8SBrtFOxfRBG6hHIEjYddfKV629KkRY3Y
    a4KrcFqu63OEd1rL0YywzH68RVPybDQ69xvDfahbyEB8utdIgQBcEIKPZB9RWvysxBVbWG
    XGQUl10uE+nwIfCHpBfEtGSOGmLbIYA/pnOt6M2f7AgjgrUSVmcq14Gt7bp6vyDeBIEaym
    RkiU6F1aD4OmJLJtViCkzblrAf+cmkNGL/KQt4cCyvk3oJpbZbtE7pqf/FMEKhYzrCx2dm
    ONTkx1GsuUQBNXt6aWjkqzjPxjUMdax6eLOOUROrfQ22FWC03eCM7lBq0emtOqtftUpgpS
    H9CS+f+1bPuncQGTOlG8Ls5x5BwpZhn+cr63HRYk54hnzA/Jjhv005gpxExLt/KwOVx+2u
    iRFPBmpxgxDIf3p0CAx0GadT1dshTFdskXGRulbOLwZjKKvjfzHTlt1k0g0vaYLw2ZxMfG
    sf6a8De48dczOSSGW7W4WydKoCUfQ9JBAA2/+lH83bUHTb6Jb4b0Evv+Hyq7QymiQIbnPG
    JDEJHwE4W8swCOAHUgiOsSDfiAO3nocEkWSH1+sQMi2yl87ONxFdN8traet8PjLxGxih6j
    76mqPvAZScnYcMJn22qQYkYNh0jjOtKeSzXvct1cdF8WhWiIJaRaxWdF0iqg
X-ME-Proxy: <xmx:q5FOavLmyyuJrplKNgD3HpLiJoAh41SeQdwcVKGf3mQnnKvrsMFDtA>
    <xmx:q5FOanj6t2LIGblqr9rCvzuUpNKmvSIhk10ZFTgWIW9JGg0gYgkI4A>
    <xmx:q5FOalmyq3w9W-tk5DKnrX8dGwIrPIoKXGlUNMjGDcQngHubWasWsw>
    <xmx:q5FOamV87TUrwzx6yg2W7nz_BLnEk5HP1Db-S7xRIuBW0IKRBUSkRQ>
    <xmx:q5FOaquG-8HJbvDVz9ltv57_k1qjrCmFRLLpq1Vqk3dmIukzA_yxEoBF>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 14:06:34 -0400 (EDT)
Date: Wed, 08 Jul 2026 11:06:34 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Dan Williams <djbw@kernel.org>, 
 linux-coco@lists.linux.dev
Cc: linux-pci@vger.kernel.org, 
 driver-core@lists.linux.dev, 
 ankita@nvidia.com, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Dexuan Cui <decui@microsoft.com>
Message-ID: <6a4e91aabfeb_2f05d5100da@djbw-dev.notmuch>
In-Reply-To: <yq5aa4s4i91v.fsf@kernel.org>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <20260705220819.2472765-14-djbw@kernel.org>
 <yq5aa4s4i91v.fsf@kernel.org>
Subject: Re: [PATCH 13/15] PCI, device core: Add private memory access for
 DEVICE_TRUST_TCB
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Aneesh Kumar K.V wrote:
> Dan Williams <djbw@kernel.org> writes:
> 
> > A device that wants to access private memory needs to have its trust
> > elevated to DEVICE_TRUST_TCB. That trust is established either at compile
> > time (unlikely), the bus knows the device is within the TCB to start (some
> > paravisor setups), or the device is dynamically added to the TCB in
> > coordination with a TSM driver (primary TDISP use case) and the trust is
> > elevated by driver match.
> >
> 
> 
> Do we have the last case, where the device is dynamically added to the
> TCB in coordination with a TSM, implemented in this series? Do we expect
> the CCA driver to set that up?

In this case "dynamically added" means pre-existing device converted
from shared to private operation. I.e. the model the work-in-progress
CCA patches already cover if that was your question?
