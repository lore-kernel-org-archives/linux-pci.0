Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.61.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725B6370AF3;
	Fri, 18 Sep 2026 05:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.61.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789710052; cv=none; b=bHH+Itb17PW8g8tSZXWPu0uQy/nwINaD0PgzATioOgbkJP9EKp7guR2rEIrW/lUMjVnBpvKt4J5rHKAgoDgG+PS9iSbfxo8mFeyyMxk/teo871x4oWhPJs4A6n5HhvlqKfUkUReP5bKbtTrbmT1BUkgj39GqXkocl+CQGiLdGBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789710052; c=relaxed/simple;
	bh=2oCic7brQwDjiuLicskbX68+8F87e81/EfieKTtr6JA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HDOJGUJrwogQ5gmNQZK3le383NCxK93GYA8W690FAMfNT6OJKGdHV3wHjFTPkI28A0Owl/7VnOeg0eXa957fGCdC3/2CBRyoLB7fBpuX71hC68uCGcRTf6GaKCgAGDcp5YD7k4Cmqzz4cgvQ7gp0W7MaLXjVu+WIYkHO+FNzm3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=QoZ9KifO; arc=none smtp.client-ip=188.68.61.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="QoZ9KifO"
Received: from mors-relay-8403.netcup.net (localhost [127.0.0.1])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4hmLz42ZB1z85D7;
	Fri, 18 Sep 2026 07:39:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1789709952;
	bh=2oCic7brQwDjiuLicskbX68+8F87e81/EfieKTtr6JA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QoZ9KifOGx8q3p0C+RT139x+z/y0GVIKf5apDm4ZpUkuK0jU5vejS33h9Uyzaq3BD
	 ki+Ds+H3d+jJS6RIg10lASH0ZnFeoO2+6gOD2C+Ylo5RXUFVIvha+HxnA2AUl5r/Ee
	 XNqazIFukWe4MPftwBLzNDceook6jWSqPEjaFx8wwnBC6bWpFUD8x+Yi9rrz5Bf/Av
	 nCFyvhsmDwTXGKMb69BXfQeMr4Q7vsXKRrds02s4jYyCaIZghKmZdRERx9gu5rjVEB
	 rS09sZGL1TLWihto0I3DxWmn86BmGHcTOjbu3RE+eIxJh55URj5witmsJACuavbs81
	 0NaVJLv7qt00g==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4hmLz41qbDz85KL;
	Fri, 18 Sep 2026 07:39:12 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.898
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4hmLz30gJJz8tbx;
	Fri, 18 Sep 2026 07:39:11 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 2691A5FAD0;
	Fri, 18 Sep 2026 07:39:10 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <b4ed1637-ac6a-4af5-ab47-e07309af200b@leemhuis.info>
Date: Fri, 18 Sep 2026 07:39:09 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: Skip Target Speed quirk on clamped ports with no
 link
To: Bjorn Helgaas <helgaas@kernel.org>, Andreas Wild <andiwild@gmail.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, macro@orcam.me.uk,
 linux-kernel@vger.kernel.org, M M <restafvalendergelijke@outlook.com>,
 regressions@lists.linux.dev, restafvalendergelijke@outlook.com
References: <20260917233355.GA1115024@bhelgaas>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <20260917233355.GA1115024@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <178970995084.148782.7225326446830493101@mxe9fb.netcup.net>
X-NC-CID: PLBxsupKr9TEn6xctqYG3iq+VDfVEoMCZf5Vwra4pqISi6IDXdg=

On 9/18/26 01:33, Bjorn Helgaas wrote:
> On Sat, Aug 01, 2026 at 10:11:48PM +0200, Andreas Wild wrote:
>> From: "Maciej W. Rozycki" <macro@orcam.me.uk>
>> Since commit 72780f796468 ("PCI: Always lift 2.5GT/s restriction in PCIe
>> failed link retraining") the Target Speed quirk lifts a firmware-imposed
>> 2.5GT/s restriction on any downstream port, without checking whether the
>> link is up.  Where nothing is plugged in, the retraining that follows can
>> never complete, so each attempt costs PCIE_LINK_RETRAIN_TIMEOUT_MS.  The
>> quirk makes two of them -- the initial one and the restore on the error
>> path -- adding a fixed 2 s to every boot.
>>
>> On an MSI PRO Z690-A WIFI DDR4 (Intel 600 Series PCH) with one empty x1
>> slot, running v7.2-rc5:
>> [...]
>> Fixes: 72780f796468 ("PCI: Always lift 2.5GT/s restriction in PCIe failed link retraining")
>> Cc: stable@vger.kernel.org
>> Reported-by: Andreas Wild <andiwild@gmail.com>
>> Closes: https://lore.kernel.org/lkml/20260801092152.5643-1-andiwild@gmail.com/
>> Tested-by: Andreas Wild <andiwild@gmail.com>
>> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
>> Signed-off-by: Andreas Wild <andiwild@gmail.com>
> 
> I provisionally applied this on pci/misc.  It seems to address at
> least part of a v7.2 regression, so it probably should go on
> pci/for-linus for v7.3.
> 
> But I'd like to have it in -next for a bit before asking Linus to pull
> it. [...]

Great, thx -- and yes, -next sounds totally fine for me, as this fixes a
delay, not a hard breakage.
> But IIUC Aoxtj still sees issues with 72780f796468 ("PCI: Always lift
> 2.5GT/s restriction in PCIe failed link retraining") even with this
> patch
> (https://lore.kernel.org/all/331e97c7-e422-420d-9f3e-5d9f734464b3@axtjblog.cc)
> 
> And M M / Mich (BCC'd) also reports an issue that (IIUC) is not fixed by
> this patch (https://bugzilla.kernel.org/show_bug.cgi?id=221919#c3)
> 
> So evidently there are still issues but maybe this patch fixes part of
> them?
Yeah, Maciej ten days expressed that we to look into this. Anyway, I
suggest someone that is affected by that problem starts a new thread
(please CC all those that are affected by it and the regression list)
with summarizing the current state + this patch, as this thread got a
bit confusing... (please drop a link to that thread here afterwards)

Ciao, Thorsten
