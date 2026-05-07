Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [194.59.206.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E1733A9E1;
	Thu,  7 May 2026 06:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.59.206.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778135013; cv=none; b=S7Qmg+nJmO7m1MMdjdln+3r9NJMT5MbJzcvaBA2gVqnIKKlZaM5DSFFPghMXUA0RpmMLaOmyoKglrmsnePzs5Gm0JudUtSyim5T1r5vXwbBzWrIkLmgO1cJfPBG7bLznRPHANqUdQ0aGU1U49nJoV1U3/JW8yGgASm+CneGNr4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778135013; c=relaxed/simple;
	bh=vL4DabYOD9B6tSqbsgRgvxI82cLXViFTzFEHJXUIi2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KACLrDvvd3V/pejtVz0jWas+9sJMJkkXlSfVQmIg7D5UzzYFrKGEK275xQ6orBWpmo9E3V4PsT04CNfNFTTtNuvlaLabgUg02fDO/xJfW2qbru6bUzbhLhfTaMXgc9R8zq0Ccyfaw8kC/preyUD5DtzZ2G9tmNhPw1i5eHLqSAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=XNIf6V+d; arc=none smtp.client-ip=194.59.206.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="XNIf6V+d"
Received: from relay02-mors.netcup.net (localhost [127.0.0.1])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4gB2571NKJz4Btc;
	Thu,  7 May 2026 08:14:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1778134443;
	bh=vL4DabYOD9B6tSqbsgRgvxI82cLXViFTzFEHJXUIi2c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XNIf6V+dLxp4NXjq3SL/sM3dunYoc4rEgiJjpIMFWwwDcyry6YZcy0uSDt83otv2b
	 N7BYL6pV4KVmhtrhvjJAFzjuhSJaz8Q3kBUe49JwAWwJ8PSXdl19SAcWXkMhb/ykjy
	 2ffV2RLyuw55+EyljhODmkX/HjbPjU/DLsMhI5so7J9Xwzr7fXS1bNU95zxB8CX3UY
	 dmkfkZEC1lIgnU8W7XYgqwYcO+lScV07XBzCR5aW5wGsg02ff+r2w6mi4C6z7hjJf8
	 QDq/DMwSmU3qaz+VRjfvtOyip6No7qmuq1cT5eIVDLpy7vGuhaoUIK3PfktAXttS4D
	 1ruFoWoc6Q6jQ==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4gB2570fbsz7vfc;
	Thu,  7 May 2026 08:14:03 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4gB2561PKgz8sZg;
	Thu,  7 May 2026 08:14:02 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id AA4FD5FBF7;
	Thu,  7 May 2026 08:14:01 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <c0305eb4-811f-492d-9ee1-db1e8759af3f@leemhuis.info>
Date: Thu, 7 May 2026 08:14:00 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] amdgpu fails to load eGPU after 6.19
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 Rio Liu <rio@r26.me>
References: 
 <a1FodrO_nl6UemO3VLBk5Gsu6PjvxLU-OYhvJEMeKFem-Bpi7ZXDHrIxtwsTCmpn-WndBxnzZNtdKJy_V6PjafnFjSKz7sr1eEfGobRzpgs=@r26.me>
 <4dfc25f2-f660-c234-4e4d-c5c76216523d@linux.intel.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <4dfc25f2-f660-c234-4e4d-c5c76216523d@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <177813444197.2807031.18438117709254262244@mxe9fb.netcup.net>
X-NC-CID: n2LspJU92EYRXPtK9VRjUeEldcGFM4szdVWA2meL9Wpn/7iW6ko=

Lo! Restarting this after deliberately waiting for a bit:

On 4/14/26 16:28, Ilpo Järvinen wrote:
> Please note that there are also some fixes to the new algorithm which are 
> only queued for v7.1 as is (I expect they'll be backported from there 
> though). They're currently in the pci/resource branch awaiting PCI 
> maintainer (Bjorn Helgaas) to make PR to Linus.

FWIW, I assume you mainly meant the patches from this series:
https://lore.kernel.org/all/20260324165633.4583-1-ilpo.jarvinen@linux.intel.com/

The series iirc fixed a few regressions at least three people reported
with eGPU setup in 6.19/7.0. So I guess it really would be good to have
them backported. Which leads to two questions:

* Have any reasons against backporting turned up in between?
* If not, could you or anybody else be so kind and submit those for
inclusion in the 7.0 series to get those regressions finally resolved
for users that don't want to run -rc kernels?

Ciao, Thorsten
