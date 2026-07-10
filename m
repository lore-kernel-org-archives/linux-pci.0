Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7791E520A;
	Fri, 10 Jul 2026 01:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783645219; cv=none; b=kSdEewRJPiaQ0huGcQO1xNV4nzPXoNht7O0s0QPkSuLI3u4t24VR2MFXBSoUa1f8Q6ugJFJTDlnioMjdqHQxYkfCfJPnBl4oajusX1eihw3cT9CupFG44wtRwFyP60WGjJmzERtcjvun2PC/Q2Vsc8MPZAgaebitMUCwOarz694=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783645219; c=relaxed/simple;
	bh=EJZbODbFVgJbdE4UIlTAI9uD9mvXfnKDh5pOXHzad7Q=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=R7drWYNCw5yJAji3V7EF75Wzh7EbHDS2VTwQ38DDINZJX+WDMqHcyHp82ZHZCw7NCILf599V4Hw1YtJ8n6Flo3udUmd6po1g8kiiyQHCA1khEHar7dEtrBHtVnLECeLLOl+Ns9CeQ334+/sJTwQ6tZRR7kf6taPIrHXYxtB06A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cyGtFiCQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cyGtFiCQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF151F00A3E;
	Fri, 10 Jul 2026 01:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783645218;
	bh=xyyNanMFUeN5HTPAdaOwZPnsZkZMBRw11NKqWO8z7cc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=cyGtFiCQ4yIZiNdfUonk88SuqKdNkSvoekD1AYW5WvBWiM+pWtNqnsEzUwjIng63H
	 FknChLZiCyGTIguGyxNgHA1pbsgPfq+Z0cHKSkQHUUHgEWmYYrF+DVZZdAhtKF+WW8
	 6fkVa1KivfiK1WQuDBM0X2NI4S0fwU/jyaY91casjklGCwwezotJys1CV5XkcwDK2P
	 FsQwutJxyJR7GAdY0GyBXCpNwTBKUIC3VQwqo16ykkKtZAY9IH7lFO6mO3Nxo0xtXL
	 pxDnpBucMY2ogBvvqjW1lvNgwmFsF+zGrrCCRM0WXsV14BzAg0XZR93gqJD1Mgb+95
	 HfbOm3ZoJ0kpQ==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9F722F40068;
	Thu,  9 Jul 2026 21:00:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 09 Jul 2026 21:00:16 -0400
X-ME-Sender: <xms:IERQasPI_Snw_dLJHO4xQFPm2xHe44JPUDRyUEF_gEyWiCqaJeYM9w>
    <xme:IERQajZ0nixIO_jbzcbmWll1aJPbaWBVCkpailMKDCeyDzV4PCcr8vYe_ng2AiT9S
    DAQthRFkr34ZxUiXylUvO2Do4ysOVjRUAvmogiL2c4uy_Z8r0dDTuon>
X-ME-Received: <xmr:IERQaotCZibFKRVCVWID7cytv14bRmDjQV6sC6Of4DYOlqdVv2-_QPTcS890EPl0Pn0MV2SflSVXtwh6ehcfKJL3sFIxbwC1YHQ>
X-ME-Proxy-Cause: dmFkZTGETUaO6G1qAZdr3NWdqNln0wMNRE7x3H3tSa0EnamCu23L8SKnod99bMPRyJmX0W
    lwqc1OR0mAIMD3uBbJHYj6HOh8Yszr9M3oQFI8XYorv4QZCpGzuJMKr5avospU6ET0kTA8
    iXMBpp1UDpdex7sHw5wRnT1daHrq5SQwQRtScEX4T5QAtNvXLLJKzdZTz1vMK0NA3EP7ng
    /s743eTmYK9zAMh8+L/U8DBfpeUot5OIQBjl5ftKBxtFBKJBV1RacEkyuXi3wxk1tezejP
    s/1c8MtwuK+uVujtpJ9y+d1cmQ8JH2ZVeSO2WJT7BJBG5wWuclp0e2131f0Dd+P7wHtNSb
    HeRbxk1CgGcEhkOFYKUpxQW3wcXcFOISnBw3lF4fCkeKhX7xOWy6bvV6fp8yhTmGijNrCp
    6BNSWxo/uMiCz++xQLJyhniWUEBk3w8kdS8XY1d2CujNvc+nCUS+Vjx9vZSogZw2GHZtaa
    cal6ExJD3RTa+NXxrFtKQYgQdwT55G8qWINIaW9D0lnnGCdJ+awb+GR1ot+EYej8gPpktY
    KZMfo2Slp4tnYEgrtNEBd8d8Gwe4jEVGsO5UHNUoG7kydwwb4A8do1qbad5dBPb+Gq9mAn
    zOywUU+ubYeuJ+ulbWWy73+lYh674IyITMntsDagzcjhhChXpryAMBM/XS2A
X-ME-Proxy: <xmx:IERQaiqOrzGuXwiUYPheVWyHhvwCYWruEKK4TfTl10HYHivkLXB72w>
    <xmx:IERQaoS86FPO7pwHLnzfT7DG65k3xZF-jmVTXKFaX-lLqjTWiJH-dw>
    <xmx:IERQanbj7ypqbruXF4MZzMZGmq0z6GiRWRIfidn431h3p6XAATG11w>
    <xmx:IERQap7CCTpHBzC7rH33jNu0Sr8mlVDt3mX8IhgxYtSOLC1OeG06dg>
    <xmx:IERQaid4u67qtskVySz_IMW5kv7qXC1FHRjSuQbOd50_uh3me5lIWBFn>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jul 2026 21:00:15 -0400 (EDT)
Date: Thu, 09 Jul 2026 18:00:14 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: Srirangan Madhavan <smadhavan@nvidia.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Dan Williams <djbw@kernel.org>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Vishal Verma <vishal.l.verma@intel.com>, 
 linux-cxl@vger.kernel.org, 
 linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, 
 vsethi@nvidia.com, 
 alwilliamson@nvidia.com, 
 Dan Williams <danwilliams@nvidia.com>, 
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>, 
 Vishal Aslot <vaslot@nvidia.com>, 
 Manish Honap <mhonap@nvidia.com>, 
 Jiandi An <jan@nvidia.com>, 
 Richard Cheng <icheng@nvidia.com>, 
 linux-tegra@vger.kernel.org, 
 Srirangan Madhavan <smadhavan@nvidia.com>
Message-ID: <6a50441e2bb5e_3cabcb1003e@djbw-dev.notmuch>
In-Reply-To: <20260709010304.680422-8-smadhavan@nvidia.com>
References: <20260709010304.680422-1-smadhavan@nvidia.com>
 <20260709010304.680422-8-smadhavan@nvidia.com>
Subject: Re: [PATCH v9 07/11] PCI/CXL: Discover the CXL reset scope
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
> Add reset context support to validate that CXL Reset is function-scoped
> before advertising it as a PCI reset method. Use the Non-CXL Function
> Map, ARI/devfn rules, and CXL.cache/mem capability bits to reject reset
> when another same-scope function would also be affected.
> 
> If the Function Map cannot be read, warn and conservatively treat all
> candidate same-scope functions as CXL-capable for scope validation.

I was hoping that all the sibling logic could be dropped after the
realization that function scoped reset *must* not affect siblings.

The small corner case of multi-function device, but only function0 is
impacted by CXL Reset can be an add-on patch if someone really needs it,
otherwise just do a simple:

        if (dev->multifunction)

...check for now.

It would also be good to fix the bug in cxl_reset_bus_function() with
the same check. That handler currently allows reset for multifunction
devices. Give Alex credit with a Reported-by.
