Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04142DCC1F
	for <linux-pci@vger.kernel.org>; Mon,  9 Feb 2026 09:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770630176; cv=none; b=EsCQzTE68JEsVhdd+IUe0L7knE7i/Wcz4hE17DXkYo6YrWLfP9X2f6gu/BdtLVlrtpalJ9xdp8OsmtAs4J9vQ4F4beDFwbssX/SZX39aHloAj5rUE7SjQUXO4IOKHdGAo5ABBddt5JDC9dC2SDA1EVhQZKRljGcSKVsAd3NxDmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770630176; c=relaxed/simple;
	bh=UOsVwSOTVWc4zYryltyKNWs3NU6VnGBHfl/YQ/sPQuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TQ5kHAj4st6YtqxvcpV3cZUvtUy3s4n1H8wNttw9UiVUr4y06kuK/1RW1zngV5dym2ACvJBvbT0gNN5SuCGfJZt4heQ9d4V610TiXjUrppYbPZBBEZ+2ljNOcG2fQJFjF46B3Bzops9hpGDgwpYjBxx2j0eepj6iIK5v4k8V+vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=HMt1kAcK; arc=none smtp.client-ip=188.68.63.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="HMt1kAcK"
Received: from mors-relay8204.netcup.net (localhost [127.0.0.1])
	by mors-relay8204.netcup.net (Postfix) with ESMTPS id 4f8fjd6pJZz8dxV;
	Mon,  9 Feb 2026 09:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1770629830;
	bh=UOsVwSOTVWc4zYryltyKNWs3NU6VnGBHfl/YQ/sPQuw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HMt1kAcKjnMrIJ+UAu4h3D0YtlXRc7t+3XZRlL5sWFYL1/jqDaY4dBxKd946HIOQ+
	 aZhm6DDzLpbT4vQ64yH4gk5X9t9h/p3n1bE7gRdvRl8zJfJD5ckOuNnJlY0V8G0C86
	 0hiiB7yWNwnzqTHk4Df9QfxTPuaKqVAiownHz4gA/O4PonQNjwFlZDJInix3xrTxzg
	 itHlX9CPh2a199Su0lxtv9P2atVU/0kilwrQbOh/D7jXXECO30RQ4nB2Cq4x6PX4vT
	 VubH+K8g53S1C9rIJX0vP49FrAAvc2vcIXlc4L1Q53kTjA5GzaiB7xfF/MldKAwWo9
	 IINgsry+3VWmA==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay8204.netcup.net (Postfix) with ESMTPS id 4f8fjd63Zpz8dvw;
	Mon,  9 Feb 2026 09:37:09 +0000 (UTC)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4f8fjc2J3Jz8sbs;
	Mon,  9 Feb 2026 10:37:08 +0100 (CET)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 346F0671E0;
	Mon,  9 Feb 2026 10:37:06 +0100 (CET)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <94b6639b-d1f4-4d03-8ec2-3b24d438bb9b@leemhuis.info>
Date: Mon, 9 Feb 2026 10:37:05 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Disable RRS polling for Intel SSDPE2KX020T8 nvme
To: Linux-Fan <info@masysma.net>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Hui Wang <hui.wang@canonical.com>,
 Nirmal Patel <nirmal.patel@linux.intel.com>,
 Jonathan Derrick <jonathan.derrick@linux.dev>, linux-pci@vger.kernel.org,
 bhelgaas@google.com, raphael.norwitz@nutanix.com, alay.shah@nutanix.com,
 suresh.gumpula@nutanix.com, ilpo.jarvinen@linux.intel.com,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
References: <20251008165345.GA627277@bhelgaas>
 <80340269-c702-442d-a461-300a2041a497@leemhuis.info>
 <cone.1770586239.550948.1302334.1000@masysma-18>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <cone.1770586239.550948.1302334.1000@masysma-18>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <177062982667.1071451.13713845420128483568@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 346F0671E0
X-NC-CID: YoQm/GuUU0Zk+dLVTzzYaruRDeiZxJC6CeBGBATAe1eTOa3qQBM=

On 2/8/26 22:30, Linux-Fan wrote:
> Linux regression tracking (Thorsten Leemhuis) writes:
> 
>> [top-posting to facilitate processing]
>>
>> The issue discussed in this thread is still on my list of tracked
>> regression, which got me wondering what's the status here. Did it fall
>> through the cracks? Or was the regression maybe fixed already and I just
>> missed it?
> 
> Hello Thorsten,
> 
> I saw the regression was closed here:
> <https://lore.kernel.org/regressions/e03d4af5-5cdb-4bf4-
> a568-06b9213247a0@leemhuis.info/>

That is not much relevant, what is relevant is the bug report and the
activity, in this case this thread.

> I am one of the users affected by this issue and are currently running
> an old Linux version (Linux 6.1 from Debian oldstable) to work around
> it. As a user I would very much appreciate an upstream fix.
> 
> The Debian bug is still open
> <https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1112238> whereas I
> think Ubuntu got a patch working around the issue for their users:
> <https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2111521>
> 
> Is there a chance to possibly include the workaround in the upstream?

The workaround: maybe. But getting it fixed is what you want, and the
workaround might be the wrong solution for that. That's up for the
developers of the affected area to decide.

But the thing is, this thread got messy and doesn't work on its own
anymore (it should ideally answer questions like "What does the
workaround look like" without providing a URL, as developers are busy
and might not follow it; any by now devs likely have totally forgotten
what this is about, so a kind of re-start might be needed).

But maybe we are lucky, and some developers of this area will reply
within the next two or three days.

If not, I'd suggest checking if 6.19 vanilla is still affected (fixing
6.12.y comes later, so let's ignore that for now). If it is, check if
the workaround from Ubuntu fixes it there. It might even make sense to
check if a revert of the culprit fixes it, too. Then report your
findings and sum up the situation briefly (somewhat similar to a new bug
report; people likely have forgotten what this thread is about). That
should work as a good base to restart things here.

Ciao, Thorsten

> As the issue is reproducible on my system, I should be able to test some
> patches if necessary. Tests are not easy to perform because it degrades
> the RAID system and I would like to avoid damaging my “production” data
> hence limit the tests to the required minimum.
> 
> But if there is some real doubt that the issue is still present, tell me
> and I check it again with a more recent kernel version?
> 
> Thanks in advance and Kind regards
> Linux-Fan
> 
>> On 10/8/25 18:53, Bjorn Helgaas wrote:
>> > Nirmal, Jonathan, can you confirm that when RRS SV is enabled for VMD
>> > Root Ports, we should actually see the 0x0001 value when a device
>> > downstream of VMD responds with RRS?  From the log below, it appears
>> > that we actually get 0xffffffff when reading Device ID after a reset.
>> >
>> > On Thu, Aug 21, 2025 at 11:39:36AM -0500, Bjorn Helgaas wrote:
>> >> On Thu, Jul 03, 2025 at 08:05:05AM +0800, Hui Wang wrote:
>> >>> On 7/2/25 17:43, Hui Wang wrote:
> 
> [...]
> 
>> > The patch is here:
>> > https://lore.kernel.org/r/20250701232341.GA1859056@bhelgaas
>> > and the log with that patch is here:
> 
> [...]
> 

