Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37311233723
	for <linux-pci@vger.kernel.org>; Thu,  4 Jun 2026 02:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780541370; cv=none; b=qdrn7u2kmXDPlb7CyD8d+82xkzlAIcM58lptzn4BlZAmbuL4vEcFa0GpHVG+HavsI/s5kb3v0XYLQ0cqM/DfORhH0P8vftfppB96IrNBH0E3YTbEkd6afSNdygjpSEihqRBoc1eCZKWrh9rgxnvYPa6IyXM6cOxzRGS4L9l8mS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780541370; c=relaxed/simple;
	bh=kU1FvHElE0vLUIbTFab19y8yYx3wY55ejX7hIJnCV8o=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=P13W2P6Yi3cWztK30TAJzJ9rxwA7gsXdySvaZIUuOFhRo4sGor03ASr+mLGS6QXm85zlC12CJVYXXHTF51Ar0J8pMPHI9tmWmh0EtHZjO8YZOgC2x0cHt0cRjOBgjQa9FIksB2G/YYV6q+fqHw4Zy4eZkf9D6n5QqFqUVmulPSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKO3F+91; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKO3F+91"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0E31F00898;
	Thu,  4 Jun 2026 02:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780541369;
	bh=aik8eohdmtfo2RpDYghFBRoMofhORfnzg25HZl50gEA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=WKO3F+91sV382D1t6FJMqd1/wyl3I5bLS6zGdzb9g2zsl97fIrYr4BLr2i6NXViz/
	 lHmT307wXwbr2BfA976J/yw5gsNH+09bQZYSYEZGDzVUVvnanEf8YNqBAPEUqiGwZt
	 fBZvztZsTOv7/KW+M0OImSeUsBynPQ0DER10WLYnDBUClJ862AQ1aeADJ1IBxVk2lH
	 YLZw/o/M3wGy1l+VZJ4bUAzmCULCNmyPG57a4jXOXJH4tLFMhrIKBDXMv0yvA+AkhQ
	 iBOy841Eg7ohhiuKK6oX/1qVDq2f5HIp3jExhJtLRjGzbr67C57Rt8dOjLN9k7V+ET
	 HnfTlJz5qYDJQ==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id C123BF40086;
	Wed,  3 Jun 2026 22:49:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 03 Jun 2026 22:49:27 -0400
X-ME-Sender: <xms:t-cgatryqy0OyvgXO04xkRv35g-6lYHhIY_b1Ty8ETPyLv9WxJYe1A>
    <xme:t-cgagG2CA_a78cBJvzgoSh4Qms9aElKfXLrokr1rOsGc_gPOATDdImtcXGFQlDOp
    u4RGklXPty4QydJ6-mTa6dBKvfhA7gyVEWGpvBrwixs-V0huAWT_6Q>
X-ME-Received: <xmr:t-cgap_UCUIewEMvObmg3N1bGTWysy68SNmNeYYDFIAStQK3KsnDlL-3dQSApABnfdNiLUYMKdnVWkvtUt6A1T3ZwzGEM9v6A3k>
X-ME-Proxy-Cause: dmFkZTEtqhMG0NUyBxp8aYmzT28DEqHS47lxu4BQ/fue1GR7q3zSl1SM2KBn0T67qveHxY
    1GWlKssU+ZbjxeAD/5shx4xOZhDOIoUDPBFqQxIZnKgKBLofNDgGYZ1Y7Xh/X8mhqVIyrQ
    kRh2NUfQL1Yd9s++1GGzjMT74BsxTXscua54yLFRKWcf70aBo4gQHeaht2Ued42RbiBrn4
    J1+CFrTdEDyqYfBrDhKGKGxRZzPu3Rp23li5tkebClm1j9m0+y0DVtHK26J7DWIqpiDfLG
    K2FE7n4LXwCOY1DW/VYd5v/wOpcX5wnebx7M4MDhGoZKD4VEr880xNV+PUGWjjsdBz4oDM
    hvF9oZfs8AUohzyWtc3oUE6JgW455+aIvkeutoz+Oq12jNH/+6b/puGK8+qxmUOqF3q6oV
    LB6pAAPIT0w3dFOxVqlk7DP1uVdYLyXAao8gtJWi7r538op4k6bCeWZLT42BS6acFsINII
    hsbPhpSZw4gZno9K7C2N1x+uTXlkM9rR+3imZNxk30K3d1xC6VOkBGfHfAKbSzHbvjqf2+
    8BUmK4z1zCWTVFSoJ3fftyXvlspsh4khUYlwb9esq/zjvpkonSEDvKztPBFy5kgFqk532R
    QhBOLyvBlAT3D1vGyh+P5QrcRYWCv4tcgQ8J2YB+k1VL2YlIXyK+8jevqUlA
X-ME-Proxy: <xmx:t-cgalQxXC7HNHmK2UrqT-U-N1q1iqAWdzzKckFw4G8NcdIXeRRyNA>
    <xmx:t-cgamqDrf1-jM8bjrprrdmMky0nnU-01N3ilNNeH1Fkt9RuaiUXHw>
    <xmx:t-cgaqOPXax1XQMaDM9g1PxnAwASuMfXJ_7dq0GX0yEqQRxwwHNyNg>
    <xmx:t-cgakwieEvgGClLR49rOi8jzNiyY_9ln2nZBlLP9_qqGELdMatDZw>
    <xmx:t-cgamwgjXYuzprzNDYHMCiGUDkbA68dOOWnA6XlmDjEybhAGE8FH-Ne>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 22:49:27 -0400 (EDT)
Date: Wed, 03 Jun 2026 19:49:26 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: Srirangan Madhavan <smadhavan@nvidia.com>, 
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
 Srirangan Madhavan <smadhavan@nvidia.com>, 
 rrichter@amd.com
Message-ID: <6a20e7b619c9f_42b910098@djbw-dev.notmuch>
In-Reply-To: <20260528083154.137979-4-smadhavan@nvidia.com>
References: <20260528083154.137979-1-smadhavan@nvidia.com>
 <20260528083154.137979-4-smadhavan@nvidia.com>
Subject: Re: [PATCH v6 3/9] cxl: Add reset-idle and cache flush helpers
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

[ cc Robert ]

Srirangan Madhavan wrote:
> Add helpers to collect the CXL regions affected by a memdev reset,
> verify that those regions are idle, and invalidate CPU caches for the
> affected address ranges before reset.
> 
> A memdev can participate in an interleaved region through multiple
> endpoint decoders. Track affected regions in a temporary xarray so each
> region is checked and cache-invalidated once per reset operation.

With the new proposal we still have the HPA range per-endpoint decoder,
so you can still check that the endpoint decoder is not mapped via
request_region().

Probably the more important optimization is to enumerate to CXL when the
cache invalidation routine is global. That lets the reset implementation
do its own simple "one global cache operation per-device" rather than
per-decoder.

Now, thinking through this, recall that some AMD platforms need firmware
help to translate the decoder settings from per-host-bridge normalized
addressing to typical global HPA addressing. See cxl_prm_setup_root().

I think for now HDM restore can not be expected to work on those platforms.
Either need to cache the translation at init, or teach the restore path to
reverse translate SPA back to the HW decoder HPA values.
