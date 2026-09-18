Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6E136B934;
	Fri, 18 Sep 2026 12:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789735881; cv=none; b=kDxqrtgZDtRDURAtsvXskykZyyNHu94nhzHMlfRZKM0uAs3BymnxJM3KfflKpsKJ4XM3VGyUfP3/Dn//ORyCqLu++FNGBrAx0xX1G3T7C81SBBcMTA/WFGA/dRt6rx5xvgJ0KJTMOVwPn1BesoCypiC7+qMx27YBHa/O9Xng98g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789735881; c=relaxed/simple;
	bh=ik8phrAa3WuGdW5qrQtAtTgkz+G/77HdXtv3/mSjnYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ov0CCinJLrG5noX13aFJvoEcKuMHaPdhQOdKuJS7tZ+UEKroC7wJ3cXc5rdMaefcWQ1ccnMNw0J88E0nHGSaiEkQ9D6UOqSPE/PZM5zdGpJ95fIIhx81UGmPrzsPYDryghFaoPHkY37L7duYTdfaNvIr4rB74WXik+ztZrNCrYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=IN154n+t; arc=none smtp.client-ip=188.68.63.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="IN154n+t"
Received: from mors-relay-8202.netcup.net (localhost [127.0.0.1])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4hmXYW2jKyz4F4s;
	Fri, 18 Sep 2026 14:51:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1789735871;
	bh=ik8phrAa3WuGdW5qrQtAtTgkz+G/77HdXtv3/mSjnYQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IN154n+t4iQOjc8ERZJXscYOC3mr/ppEE9a0TTID5LaP0sVC2EV2woGJtVqIXdTxn
	 xcDIL11E8JA2eKYyOjWG/dGjhhhl4gkqqAKTE92Q9VO6YhZmBIDja1By5x5b4kX65v
	 dym/uRg250AmbUdRw5wsWZwPg05EacBA30J24FcOh3HUcS1uN6k4RB1WDKo7FoqZ8F
	 MpORYwlhGanT2EGWEspzFgJ24tibgjQ3yNKomedQbCqNnrzJFk+Y3q0jD1OCDhyzzs
	 gVQlpzLCaQuijvW6GkJ0pNEriOKMJU1hmsrA6O2LQTmu/+XRy0/8MdM5HahcXYQ1Sz
	 4E3E8J5KBAqrw==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4hmXYW1m75z4F0n;
	Fri, 18 Sep 2026 14:51:11 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.901
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4hmXYK25rVz8tfy;
	Fri, 18 Sep 2026 14:51:01 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 7BC085FA16;
	Fri, 18 Sep 2026 14:50:52 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <c4d64244-0fef-4b2a-ab34-a0d107bffffd@leemhuis.info>
Date: Fri, 18 Sep 2026 14:50:51 +0200
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
Cc: Bjorn Helgaas <helgaas@kernel.org>, Andreas Wild <andiwild@gmail.com>,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-kernel@vger.kernel.org, M M <restafvalendergelijke@outlook.com>,
 regressions@lists.linux.dev
References: <20260917233355.GA1115024@bhelgaas>
 <b4ed1637-ac6a-4af5-ab47-e07309af200b@leemhuis.info>
 <alpine.DEB.2.21.2609181131520.57799@angie.orcam.me.uk>
 <6846f455-fc77-4cec-974f-6b9d72ae0654@leemhuis.info>
 <alpine.DEB.2.21.2609181231300.57799@angie.orcam.me.uk>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <alpine.DEB.2.21.2609181231300.57799@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <178973585293.1279724.2255250960494080152@mxe9fb.netcup.net>
X-NC-CID: JTWo6+LlVvgYAXZsj8MtYE4OwBsrFc3QyFk6M56c8yy/4yvDPJg=

On 9/18/26 14:18, Maciej W. Rozycki wrote:
> On Fri, 18 Sep 2026, Thorsten Leemhuis wrote:
>> That being said and wrt to the "a lot going on": seems this causes some
>> devices to not work for iirc at least two reporters. Would it maybe be
>> better to revert the culprit and reapply it later once that is sorted
>> out? Or is this not an option or a bad one for some reason? Reminder,
>> normally Linus in a situation like this wants regressions ideally 'fixed
>> "within a week", preferably before the next rc':
>> https://lore.kernel.org/all/CAHk-%3Dwi86AosXs66-yi54%2BmpQjPu0upxB8ZAfG%2BLsMyJmcuMSA@mail.gmail.com/

Disclaimer/reminder: I'm an outsider trying to ensure regressions are
handled well, I'm neither affected by the problems nor involved in PCI
subsystem development.
>  Reverting will cause other configurations to regress, so this would be 
> replacing one regression with another.

Well, guess so, as regressions and fixes for them iirc have stacked
here, so there might be no good established base to go back to. But
*normally* going back to one is what Linus afaics wants to actually
prevent exactly a back-and-forth or an exchange of one bug for another.
He wants to ensure that people can always feel safe to update. See these
quotes from Linus for details:
https://www.kernel.org/doc/html/latest/process/handling-regressions.html#on-back-and-forth

So yes, not reverting might be the best at this point, as 7.2 is out for
a while already and so far there are only two reports iirc. You folks
are the best to judge here. That's why I'll also leave the other aspects
you raised to others.

Ciao, Thorsten
