Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [185.244.194.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7F22D1911;
	Tue,  4 Aug 2026 05:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.244.194.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785821649; cv=none; b=pDUOKbBaisZ/lQhcSKcRDEA2ZCmxFrBsVo6X3wLP2Q/16iF5FQThzSPyIM5CCVgjhg6TG+Ud4NCd0UvOhdks2CdXUSxo0XrZWyLNoc22NvV+nw+1YuS9n/WyDASSnyko7HMH4TqZrJa+SVt48bHmd/pEiJjo1+A+GCDSt9aTEXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785821649; c=relaxed/simple;
	bh=XDX3InHnxqjE04awZn3vDAys7rMEwbepeIgctIbhiWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UggQSVVuyTIHV1So5vYR1n13gZotKCgnBkUMQReO7VG8c7G/8KESy9dQyvlI/MA+ZhxzMVUCGlb9RHX61uMj2jYfEw+nD9f95/dAWj06fBmWISNDlRZW7yedbhtt53g5xCOZN6OIzwbpNzZE5l5S9PkjdabjweKY/kWWMqGRRLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=CASGFBRi; arc=none smtp.client-ip=185.244.194.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="CASGFBRi"
Received: from relay01-mors.netcup.net (localhost [127.0.0.1])
	by relay01-mors.netcup.net (Postfix) with ESMTPS id 4hDhyg53pKz963V;
	Tue,  4 Aug 2026 07:32:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1785821579;
	bh=XDX3InHnxqjE04awZn3vDAys7rMEwbepeIgctIbhiWA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CASGFBRiZpaYijzCssEQUbz2LB8oxjAR54XFjzl1QV22p5vqSgK5aKKbjxrVHcVTB
	 aliTgpl3AnT4Co4ZIAVeWvC5o0ATJ+xYLiM/dRlHpR1M0QhYCd4ZjuozuWtG3JFb4b
	 VeE/6qsMVPeDucYLi2XEWCpxgBbfQ5ssjunmQ/qeWD+vqEfrGhokU6+Xy4rjOFUhHz
	 voThhKpbxxEmpdxqFsjUF4aB8V56DCN8YJ1yXVwwhaWdpOT6JLb9UG0D3FPNMyfuf4
	 b8M4Ndusl9mjHgKG712pd+0RIdLOD/1qTAY3RGbsllfx/rG1F1UNJUks622U+kc4jm
	 gma8FDVkDwC3A==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by relay01-mors.netcup.net (Postfix) with ESMTPS id 4hDhyg4MQRz7wL5;
	Tue,  4 Aug 2026 07:32:59 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4hDhyg0KG1z8sZg;
	Tue,  4 Aug 2026 07:32:59 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 3B5585FC6C;
	Tue,  4 Aug 2026 07:32:54 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <d4d79c76-7fdb-4c80-b332-cdd2aea91971@leemhuis.info>
Date: Tue, 4 Aug 2026 07:32:53 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: Skip Target Speed quirk on clamped ports with no
 link
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Andreas Wild <andiwild@gmail.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 edwardmalik95@icloud.com
References: <20260801201244.4421-1-andiwild@gmail.com>
 <4cf40370-47e8-4143-bebe-bfab78ac2fd4@leemhuis.info>
 <alpine.DEB.2.21.2608032257510.55540@angie.orcam.me.uk>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <alpine.DEB.2.21.2608032257510.55540@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <178582157456.4181348.101007266583932573@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 3B5585FC6C
X-NC-CID: 1wtP2G6TdxS0AIFxFTNZ9JZH7VaCKKmrQx2Tenof0khfD4jxq6I=

On 8/4/26 00:07, Maciej W. Rozycki wrote:
> On Mon, 3 Aug 2026, Thorsten Leemhuis wrote:
>>> Since commit 72780f796468 ("PCI: Always lift 2.5GT/s restriction in PCIe
>>> failed link retraining") the Target Speed quirk lifts a firmware-imposed
>>> 2.5GT/s restriction on any downstream port, without checking whether the
>>> link is up.  Where nothing is plugged in, the retraining that follows can
>>> never complete, so each attempt costs PCIE_LINK_RETRAIN_TIMEOUT_MS.  The
>>> quirk makes two of them -- the initial one and the restore on the error
>>> path -- adding a fixed 2 s to every boot.
>>
>> TWIMC, this patch fixes a regression Edward reported here:
>> https://bugzilla.kernel.org/show_bug.cgi?id=221801
> 
>  Thank you for the pointer.

yw
>  As it happens attempts were made to cc me on that bug, which however went 
> nowhere as messages were sent to my long-defunct <macro@linux-mips.org> 
> e-mail address, a clear oversight of mine as I went, back in the day, 
> through numerous sites to get this updated.
> 
>  I have now asked bugzilla admins to help me recover my account.

FWIW, Artem does that and I'm not a fan of it at all -- I think it is
only appropriate when one knows the person occasionally interacts
directly (e.g. not via mail) with bugzilla (and thus I only do it in
those cases).
>> [side note: the report could be more specific, yes -- I wanted to ask
>> Edward to clarify a few things (like the actual slowdown) before
>> forwarding it, but it didn't came to that when I noticed this patch and
>> asked Edward to just check if it helped -- which is did.]
> 
>  Tested-by tags welcome!

FWIW, as I forgot to mention it easlier: Edward is CCed.

@Edward, if you'd like a record of your test result end up in the
history, reply with

 Tested-by: Full Name <email address>

to this thread, just omit the space in the beginning and change it
accordingly.

Ciao, Thorsten
