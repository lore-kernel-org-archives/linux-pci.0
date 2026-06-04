Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6BC37BE8B;
	Thu,  4 Jun 2026 08:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780560237; cv=none; b=hVKFE/iQr8u660A/K/Jzyxd/8W0ZjXlbqVtk4QQSXeouedXOvL7rcKlK2AKASzQvL5Sopv/zPpAou00PIl8Z0BiuP5tvZVBvxTrr8myB5P7XKJmApzn/A9yKfgWXoE/nRgZ2aDogDC1Fcx0i+trfgxgI7C8MMMd3VoroDf4ZFLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780560237; c=relaxed/simple;
	bh=D7HTTk6F6kBE+dCzvfd3asAiSzEpKJS6qnd+RL1mXPo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P4qFaBgGyu2e28yNKNmPkqP76FuWqGjp3Wgg6SLB1RE6ahlkBFd94AdHOVIFJFqvQAHHBZdgp/Km3OCkE8OoFSuJ4m9CYW+JfcT5Wns2COB7HnARY8/veWDbcbyOhfgvxPOA8dQ86G9n2INsENE71z7iDmRSf7ZRD6pgcjgxP7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2+9JOP7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2+9JOP7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8761F00893;
	Thu,  4 Jun 2026 08:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780560236;
	bh=MtDmzDNoUeuII4Y1W1yDaUaqhRVWW66Rsr/G5zE1ZG4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q2+9JOP7lv6i53s6FKbxTJfEopPopId4ixGCTfU80xD0uaXnNxCA3ITr2E5IOy3Qo
	 qbdggcSghizgYF+wkFp1EedckwPXbESgdZbBxbLkf8LjyB+PHj4jCPiizO2jE2CUai
	 gySfDdEe5X8KJnG5OuXy8Vn6UqZY+EPMYqe4KMLcrB4uxI4c59DIheAYSewCBcYfWP
	 J/MxHY1Pef/0KfjxBZ6fPG9ZlfYe/YYPedPEoWOMzn99fk5oBxrur1HZDHl++w0KES
	 Xbx6uA9Q7A7G0k/avpq3DlauW2w5EzP8rNJNbHxvWTh3qtr5aueGKLl2hHqiCvu6JD
	 sLoIMEi6Muj8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/10] perf hisi-ptt: Add decoder version compatibility
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sizhe Liu" <liusizhe5@huawei.com>
Cc: linux-perf-users@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260604075005.2219785-11-liusizhe5@huawei.com>
References: <20260604075005.2219785-11-liusizhe5@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 08:03:56 +0000
Message-Id: <20260604080356.9F8761F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The code silently accepts unknown future decoder versions withou=
t warning the user, contradicting the commit message.
--

commit 81956f61abf20a5e88b7e9d82765dace1fbc899f
Author: Sizhe Liu <liusizhe5@huawei.com>

perf hisi-ptt: Add decoder version compatibility

This commit introduces a version field to the hisi_ptt auxtrace info record
to distinguish between legacy and detailed packet parsing formats. It updat=
es
the recording and decoding logic to process the data accurately based on the
detected version.

> diff --git a/tools/perf/util/hisi-ptt.c b/tools/perf/util/hisi-ptt.c
> index e321f393601b8..4f52cfb4e1903 100644
> --- a/tools/perf/util/hisi-ptt.c
> +++ b/tools/perf/util/hisi-ptt.c
[ ... ]
> @@ -159,10 +166,13 @@ int hisi_ptt_process_auxtrace_info(union perf_event=
 *event,
>  {
[ ... ]
>  	ptt->machine =3D &session->machines.host; /* No kvm support */
>  	ptt->auxtrace_type =3D auxtrace_info->type;
>  	ptt->pmu_type =3D auxtrace_info->priv[0];
> -
> +	ptt->version =3D priv_size >=3D HISI_PTT_AUXTRACE_PRIV_SIZE_V2 ?
> +		       (u32)auxtrace_info->priv[1] : HISI_PTT_DECODER_V1;

[Severity: Medium]
The commit message explicitly states: "If version is unknown (future), warn
and decode auxtrace as v2."

Does hisi_ptt_process_auxtrace_info() implement this promised warning?=20

It appears to silently assign the future version directly from
auxtrace_info->priv[1] without bounds checking or notifying the user. Could=
 a
warning be added here to match the stated design intent and prevent potenti=
al
compatibility issues from being masked?

>  	ptt->auxtrace.process_event =3D hisi_ptt_process_event;
>  	ptt->auxtrace.process_auxtrace_event =3D hisi_ptt_process_auxtrace_even=
t;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604075005.2219=
785-1-liusizhe5@huawei.com?part=3D10
