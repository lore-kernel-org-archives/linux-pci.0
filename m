Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=188.68.63.162
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792571145;
	b=5iruOHwEPhHvKI1ZrPDEhg4XtI9yz0mcbx2KU0nlAtaR+Wru4MfcmTyFdXGGJrSrvxqV
	 k+S1AFh1NmTZDMK9S1JQhkD8UdHixBHtbqOGg20xYexno+DtxcTf4OBf3viks2JIBEFIl
	 C0Rc4eYff8VwP84SwhJQ752pk3Sjb6wOqHGTPuCDummwYyFsSAmaOfKW9Sgqpd/bD+hL1
	 Cm6jBavVs8lOV35pXu+A3o010xI6AwXSm9GYG3RisWg2WeLrEvL5t8XUZqlvugU8MXfm9
	 RNhpY//vTID9dQjDnfFTjlghFJVg8WPXrJEBaLhzXhhTHGZSOVe+0KkaAPti3XqIY+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792571145;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received-SPF:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-PPP-Message-ID:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-NC-CID;
	bh=M/xplg/VP58uzH9i1JrHcCGX5VNsT3nAYojevaWRHQM=;
	b=oSVS6XlvncPC4EQ6eXR3Tls5EWUnfztHYikZnc4gOa184SVwQpc5bxIjSdvS/EkMnArt
	 dr9aIG+yyE32FpqAQsQsMtuuD6O3eUwdFCJygm9H1zv+tIdrzFpsOIDYLdLdFUmwGa1Fv
	 PgQpRebkrSq5Kl+PAOel6rWxnvkfn+PX7IlIwJQ9eknI+VQIkqK59yxCgxrbzcdw1hySC
	 4RiK9o4yFYodBbHROMg8cusJb4g67yR7nYN/0BRX/L/AnsJRB+Q9fH7K8T011AP2dcpLF
	 HXxtkAus2QO6ttUgGwj3PSW0joEHzvhMlvuivXpHQjjMLV/NY92fX/zzYmWK0aeabrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=leemhuis.info;
	spf=pass smtp.mailfrom=leemhuis.info;
	arc=none smtp.remote-ip=188.68.63.162
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A72606A31A;
	Wed, 21 Oct 2026 08:25:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81A72606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from mors-relay-8201.netcup.net (localhost [127.0.0.1])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4j8j4p1RcWz42Rk;
	Wed, 21 Oct 2026 10:24:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1792571082;
	bh=TfzNxE4S0ZoHGBEXo2HLZkSpVrLGT3MBJHtmb8xMtdQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=V57cmfdJ5uUGcYMt6ktmrHuLDZldF/X9vvUE3p/1sXpQGZPxC9rXJFKryqC+HZVX0
	 dcmFTfXmSkVfCaj87JQ8F2x30IlJoHVM1XE/ixIkbcg5I/weWvcDhoWI78tLYWP+d2
	 DMf3PoFLsoZcnVt3rRzzJ2HK/F7qVrM78DbibS53TlQnN1k/HUHPHOW05J2/bBYjeM
	 dN67TAKIUBY6gjwxeOg2Rvhdy9CL4xKaLfMVOIcq4CT767A89dZtf8GcZUe/hfhbKC
	 ceyiKMdOfCc48ZZ5WGW7vQPoUzLPQXUn0eupB/yQ3+f99papeXzgsl+XEIM/89Fn8S
	 R8ly/OJKMHiTQ==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4j8j4F6pmbz45SC;
	Wed, 21 Oct 2026 10:24:13 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4j8j4F1kfgz8svZ;
	Wed, 21 Oct 2026 10:24:13 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 355B75F8E6;
	Wed, 21 Oct 2026 10:24:05 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <f9ab8a2d-966f-4e96-b905-116919c5ac7b@leemhuis.info>
Date: Wed, 21 Oct 2026 10:24:03 +0200
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: Skip Target Speed quirk on clamped ports with no
 link
To: Edward Malik <edwardmalik95@icloud.com>, Andreas Wild <andiwild@gmail.com>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>,
 Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev, M M <restafvalendergelijke@outlook.com>,
 blaat windows <blaaaat@hotmail.com>
References: <20260801201244.4421-1-andiwild@gmail.com>
 <20260917233355.GA1115024@bhelgaas>
 <b4ed1637-ac6a-4af5-ab47-e07309af200b@leemhuis.info>
 <alpine.DEB.2.21.2609181131520.57799@angie.orcam.me.uk>
 <1b2cceea-8da4-4239-a955-e0c6b475a227@leemhuis.info>
 <87c93553-d74d-4588-bd54-0ccb2728f327@leemhuis.info>
 <20260929080109.53944-1-andiwild@gmail.com>
 <c5ee9a34c6b7d3ca96538c9cc2914b603b0dce7e.camel@icloud.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <c5ee9a34c6b7d3ca96538c9cc2914b603b0dce7e.camel@icloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <179257104571.3473704.14459507000492669160@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 355B75F8E6
X-NC-CID: bwRAHJzw8nqyB+8VIDlWwRjIm9/sppZb+tvgy0PHfjJB402hrCo=

On 10/21/26 04:23, Edward Malik wrote:
> I noticed another reported incident on the CachyOS Discord server:
> [1.278083] pci 0000:00:1c.0: retraining failed
> System information: https://paste.cachyos.org/p/35d9bd0.log
> I'm sharing this in case it helps with investigating the PCIe
> retraining regression maybe there is a common denominator among the
> hardware 
> 
> Probably will see more now that ubuntu has moved to the new kernel i
> think

I don't known about the others, but if you ask me this thread always was
confusing, as we ended up discussing two different problems; over time
it became even more confusing.  And one of the issues was fixed for 7.3
iirc.

So if you ask me I think it's overdue someone tests if *vanilla* 7.3
(not a vendor kernel) is still affected and reports any remaining
problems separately anew (e.g. in a new thread) in a way that can be
read without reading this thread -- while still briefly dropping a link
to this thread for completeness. Afterwards reply here with a link to
the new thread.

Ciao, Thorsten
