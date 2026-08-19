Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F5C3264F6
	for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 12:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787144355; cv=none; b=miLUKU6wNcRHCacqgNl1FSI5rJKym4EAsbxAhvq7rZSJWSxk8a8AiplYvOKJ1f3nKsa1EnFUo8U+6esManSLlkHJMxIBPQ/nWyJD0mvefup7GeSukVaEJgTZBKbXtVyvIKBH1eKk+sEv8XeVw+WUeZWZ4Cqwj+4m3LWz69LbxGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787144355; c=relaxed/simple;
	bh=9RytVU90FrQIyGmvH9eElAZ7WG4SgDD3l2WiwHz+A2U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FCXi+d+q4IiEDvgPzep6J1FRAlGFNcfii5pUkHI67Ngm/714tq9duWl26PF81TfGEfh1aSjBZ425BWMOyr1cseCxTEZrk2jUKyrwj+gnD/sejmsFGOgOxhNQFRLQbvvvVO0Xe660WjnAYfS35hHgyA5TGEtfJM7j+RcAF25HQLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4cwUzwd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4cwUzwd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7CE41F000E9;
	Wed, 19 Aug 2026 12:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787144354;
	bh=owJlyF+0OauxR97+lwDmfrQk5NSmjRyt6tuh4JkSx24=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T4cwUzwdfiFZ5gfn0WWjkd3eYZrQWG/oVSSZVfZctIAIub1ln2be59kHKhVcpjsRx
	 K6pht5+Uge2dH/bJNAN1kmu8OftSDHSDLpI0+Qacwa75Ck9kZ5tYnwHK33NTffazAH
	 WnhynJnTAu0Gl14V1Qp1XwFsw/i5XehewsWKQ/IumX8zNlEhQ/pzTUxbTZRRm+0qdY
	 D9VqVZ3q7MlnC1aQZAnt42oNcEOovyqECSEUPIA6h8NhEggeSWBmZ59JyUKoYs2XHS
	 W0pUNmv2U5J+N9VBDb6k7QFMBmmTOeCtL66fSlhlMFZ33VbvB2lv3PucDAWZytMvG/
	 /9CU/3q778TPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/7] genirq: Adaptive Global Software Interrupt
 Moderation (GSIM).
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luigi Rizzo" <lrizzo@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260819124341.4185621-7-lrizzo@google.com>
References: <20260819124341.4185621-1-lrizzo@google.com>
 <20260819124341.4185621-7-lrizzo@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 12:59:13 +0000
Message-Id: <20260819125913.D7CE41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> GSIM helps keeping system load (as defined later) under control, but
> the use of a fixed moderation delay causes unnecessary latency when the
> system load is already low.
>=20
> We focus on two types of system load related to interrupts:
> - total device interrupt rates. Some platforms show severe I/O
>   performance degradation with more than 1-2 Mintr/s across the entire
>   system. This affects especially server-class hardware with hundreds of
>   interrupt sources (NIC or SSD queues from many physical or virtualized
>   devices).
> - percentage of time spent in hardirq. This can become problematic in
>   presence of large numbers of interrupt sources hitting individual CPUs
>   (for instance, as a result of attempts to isolate application CPUs
>   from interrupt load).
>=20
> [ ... ]
> hardirq_percent (delay_us =3D 200, target_intr_rate=3D0, iodepth 128)
> hardirq%	1	10	20	30	40	50	60	70
> KIOPS		13900	13800	13300	12100	10400	8600	7400	6500
>=20
> Signed-off-by: Luigi Rizzo <lrizzo@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819124341.4185=
621-1-lrizzo@google.com?part=3D6

