Received: from sienna.cherry.relay.mailchannels.net (sienna.cherry.relay.mailchannels.net [23.83.223.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE6D2EBB8A;
	Wed, 21 Jan 2026 20:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769027635; cv=pass; b=rntLHMmzhBxx7BXKCEOAVOXHL5ttL+1Ueyg5Gtvc5WtqUFiYJu4yq2WDXM3Q7Io2xKHt39szrUXKo/zVRCgfWGyS4gnzmvTnpAATSpvrhHj7eFS65S22m715xAJTCmCWGR4UPJoA7gpJz2uxCdjCfXDrDo1h1xxuroO5IK2ILIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769027635; c=relaxed/simple;
	bh=Z552aX0kVExCIfKdySN2bbAglURd+TDkrcW2o4Yhi2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OU9bge3wy4XkxaSoNjKTDYgNOu+peL9ynJWm8V2l/BX09nIhlVCPegFisq4402GhzrfBqDXqugQmhdjDMI0NMcntTruSZKc2oQ0gQ5bMEUUvFHtc1SwL3jeKnJhcpGbT8c0NXziUml0yc1FAUmYo6J6cgGHtI4Ox16EHCNyxbkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=qqIIN47E; arc=pass smtp.client-ip=23.83.223.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="qqIIN47E"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 95F7B921897;
	Wed, 21 Jan 2026 20:28:00 +0000 (UTC)
Received: from pdx1-sub0-mail-a246.dreamhost.com (100-116-80-177.trex-nlb.outbound.svc.cluster.local [100.116.80.177])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 085919229F1;
	Wed, 21 Jan 2026 20:28:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1769027280;
	b=YDf+Tm88A14xaNfSd/sA9mkrMqJdpzk+bNNqip6Sz2RoSl76HzO97YEXysRtVF3kbh8rpT
	PuVKR2XdFeaDoij5Vu6TqdUp0A2UqAZL1QwvxqZL/TemTmnQ97HjoIgHJFJetzX07o2A/6
	ClTWHKa3IiUdRLClzwTps3Cv3WJ/SITGLBizDnDbRVcMh8Qu8fnegLVN/I/2NLTxpneFei
	oXXZaiHb52cYV8y1+VU5tyjuh+1gyunyM9ex1P/elZd8L0HNOlLcVuTysZSU/irGA3qV2f
	61I7/kEi0t3PveX8n2tCcHmVe0rd9HW8veVzCBgN4+RzpjiwmCwyPcxp5oECtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1769027280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=OLEU+IWHigQWFwCNsTCNtiSx81qVK36E1YqdpmJUPxs=;
	b=9wQpmydhSZ4DAKuj90DqkksUGh4rFe4PaZ0fSInuzrHryGrQAu3NHHh+KXe95ULF2VmyQb
	EvMoKf+12N9dTgBJJ5U+QsfZEx+I2+5hO/4WbrHMyLCTPzJ/fMwqSmev07u1DZ7fcm8HD5
	UXmyTQGOhw8LMzjK3RUYCsKOACLV/OZnCPMQgDaA0CduglFm5YkG3iq/uT4WahF0mODFsP
	uE9u2HnkM6k9CWEbUZZA5hbBKOGkH5wVRUU9ohIBu54nrLbxqLuN36TDsQIMe6NXfNLzep
	meqDn8RmQVgEqF28SXF5fwM7EQ3yh/7B3CmwKfNl1FoqSncpaMEOyWziN54Fqg==
ARC-Authentication-Results: i=1;
	rspamd-7699b4d5f4-d56gs;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Befitting-Thoughtful: 7205461232eba4fe_1769027280441_926034288
X-MC-Loop-Signature: 1769027280441:2479068373
X-MC-Ingress-Time: 1769027280441
Received: from pdx1-sub0-mail-a246.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.116.80.177 (trex/7.1.3);
	Wed, 21 Jan 2026 20:28:00 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a246.dreamhost.com (Postfix) with ESMTPSA id 4dxG3L5zt3z107r;
	Wed, 21 Jan 2026 12:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1769027279;
	bh=OLEU+IWHigQWFwCNsTCNtiSx81qVK36E1YqdpmJUPxs=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=qqIIN47E0ZyA0WZ/apM+aiuFTgZ+1RTgrlQqVM2fMhGQ7NBRzKfCVO7vBHjJK5c4R
	 umB0zsN3LNUUdIG73ttAIiII1zHC9EhOmrlEReLo9/mNPcb4gVeIoxXLrSN9zNlef/
	 s8B2TDj4dOrQMxi3RwCYe3XRx6q1uR44Efb2De9uzrercgShzdYLh6YbPcknRTO9rc
	 v5ZCS6agWfU2jsh2iPUb7KI9qYu9gzI4lrUURXZO9ymfp9ouDS+DkBynQhgneJTNrW
	 a0nxrO7p7lcP0NzDMQe0RfBf4+mo9kMHhEsUrGO8+EAZBV5y6ra9UeUCOTOU/sa+r4
	 s7YwpFa1HvaEw==
Date: Wed, 21 Jan 2026 12:27:55 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: smadhavan@nvidia.com, dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, bhelgaas@google.com, ming.li@zohomail.com,
	rrichter@amd.com, Smita.KoralahalliChannabasappa@amd.com,
	huaisheng.ye@intel.com, linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org, vaslot@nvidia.com, vsethi@nvidia.com,
	sdonthineni@nvidia.com, vidyas@nvidia.com, mochs@nvidia.com,
	jsequeira@nvidia.com
Subject: Re: [PATCH v4 07/10] cxl: add host cache flush and multi-function
 reset
Message-ID: <20260121202755.kwbpzjxuevnah6so@offworld>
References: <20260120222610.2227109-1-smadhavan@nvidia.com>
 <20260120222610.2227109-8-smadhavan@nvidia.com>
 <20260121112005.00001e80@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260121112005.00001e80@huawei.com>
User-Agent: NeoMutt/20220429

On Wed, 21 Jan 2026, Jonathan Cameron wrote:

>On Tue, 20 Jan 2026 22:26:07 +0000
>smadhavan@nvidia.com wrote:
>
>> From: Srirangan Madhavan <smadhavan@nvidia.com>
>>
>> Flush host CPU caches for mapped HDM ranges after teardown and prepare
>> sibling Type 2 functions on multi-function devices. The host cache
>> maintenance uses wbinvd_on_all_cpus() on x86 and VA-based PoC clean+
>
>That's not sufficient in general on arm64.  It might flush far enough
>or there might be buffers beyond the point of coherence that are not
>flushed.

... and quite slow for large regions without firmware assistance
(CLEAN_INV_MEMREGION from PSCI 1.3).

>Until there are clarifications from Arm we need something like the
>agents in drivers/cache to do equivalent of wbinvd_on_all_cpus()
>(be it on a PA range to making a tiny bit less horrible)
>
>Or we need an opt in list for platforms where a flush to PoC is enough.
>
>Needs to some sort of arch_ call as well, not hidden in the cxl driver.

Reset should just be using cpu_cache_invalidate_memregion().

... now, in addition to DCD, we have two users that are beyond the
"just once at boot time" use case.

Thanks,
Davidlohr
