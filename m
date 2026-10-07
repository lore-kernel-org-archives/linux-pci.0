Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.61.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CF046F4BA;
	Wed,  7 Oct 2026 10:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.61.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791368981; cv=none; b=tp0gcoRzr3h9rbPRzKluMVAXRAcdllu59jkDGMp9NH3iky8g0cKVZFwxyFKxpPWefrNMDl2FMruf9upiWf93YtSgXyYA/r8yBTHAqz4j2Thf3jpWwLUdBhYYQJPmGGkOf1KV3IoqXPRB53KVgUlvW06Wul8v7pWSQpNsqkiPtY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791368981; c=relaxed/simple;
	bh=yispW3IdyTGJvzf6lGZYeikiyJT2NiPn3xUN6rPWlhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ceSZtmssLXp8nDSwlLrEEID3EclSAtq921lxhkzQFBV1WWYvsPHB1OicQLqd5eymmOGrSM0nZyq70NJDOaKQAfqo3xpOHHevvkD+93sSP3MDk8WUyvdafPiRtQWGSP/JQc0t0S/Ltq2mqRUsR0E+T06IGyCg2HwWGMYiWBlCgUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=XGfD9j0V; arc=none smtp.client-ip=188.68.61.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="XGfD9j0V"
Received: from mors-relay-8403.netcup.net (localhost [127.0.0.1])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4j08W427rNz8L0y;
	Wed,  7 Oct 2026 12:29:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1791368960;
	bh=yispW3IdyTGJvzf6lGZYeikiyJT2NiPn3xUN6rPWlhU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XGfD9j0VCoa7Q63af1q4X1rUtuKmuiP4B2lZihS4dFcY73L3eZWRiDh9cvJ1RxgUP
	 cWLLFVMp6BYmyUATuNobmZxc6p+B2j5AS60QKZeX4V/+lFLMXaDwtyhEUKX1lghYyL
	 tUrwZB+j5Y/9+kX5Y+dKtgevh2JLZUnMm00oQuCSc+A00UZfZfIvaay9h2vjqHDuZz
	 K486D5g1a45xm9jD9z+mxBwOIo0aArSfCbcAJtKZ/oOJPr+ycwXC8uJbHLYwlwhIId
	 orQYI9gWyJwKGBwnG89nY/9VMJP071Sw4+obys6jwbgBTbbWNMsPF7QIVZNE17Ot6u
	 T6fy2R8ZaQohg==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4j08W41Px2z8KxX;
	Wed,  7 Oct 2026 12:29:20 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4j08W34v1dz8sb3;
	Wed,  7 Oct 2026 12:29:19 +0200 (CEST)
Received: from [192.168.142.51] (90-182-211-1.rcp.o2.cz [90.182.211.1])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 1B0855FA36;
	Wed,  7 Oct 2026 12:29:19 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 90.182.211.1) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[192.168.142.51]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <8925d288-a496-4fcc-9545-7647dfc9ea63@leemhuis.info>
Date: Wed, 7 Oct 2026 12:29:17 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] PCI/AER: MacBookPro16,1 powers off ~20 s after boot
To: Lukas Wunner <lukas@wunner.de>, Alex Deucher <alexdeucher@gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, "Perlow, Jason" <jperlow@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
 Aditya Garg <aditya.garg@linux.dev>
References: 
 <CABZrw2HcaOh3DHTJtxU5dXrb3Vg19scr6+qR-xe_+R7rME35_Q@mail.gmail.com>
 <20261005231914.GA639967@bhelgaas>
 <CADnq5_O2TWeWEE1NsuCVvtWLKWyOiJHChPGP9CN4Zu=hvs+jmA@mail.gmail.com>
 <asVlzjaUFAoowH-r@wunner.de>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <asVlzjaUFAoowH-r@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <179136895939.2613663.2890463205526041822@mxe9fb.netcup.net>
X-NC-CID: xl1yC2zgZH7l9zB/2+4igi3egbT9eEhaBvfQIUbDLAAFtRdANFs=

On 10/6/26 23:19, Lukas Wunner wrote:
> On Tue, Oct 06, 2026 at 12:37:18PM -0400, Alex Deucher wrote:
>> On Mon, Oct 5, 2026 at 7:19 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>> Alex reported something similar at
>>> https://bugzilla.kernel.org/show_bug.cgi?id=222095.
>>
>> Lukas' patches fixes some boards, but unfortunately, I'm still seeing
>> failures on others.  Reverting the patch fixes those failures.  I've
>> updated the ticket.
> 
> I've added an analysis of the dmesg output as well as a patch.
> It looks like the BIOS is raising a false alarm in that it signals
> a Fatal Error even though the Uncorrectable Error Status register is
> blank.  The patch causes such events to be reported, but otherwise
> ignored (i.e. no recovery is attempted for a false alarm).
> 
> Newly enabled functionality like Advisory Non-Fatal Errors causes
> BIOS code paths to be exercised which likely haven't been tested
> by firmware validation folks, hence the fallout.  However I believe
> ultimately we *want* to see those errors being reported because they
> may point to BIOS issues which flew under the radar so far.
Well, not disagreeing, but given that we have two regression reports
(one speaking about multiple machines being broken) and we are close to
-rc7 I wonder:

Is this something we should quickly revert or disable for now and retry
again later? Maybe multiple mainline devel cycles if needed?

Ciao, Thorsten
