Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182773;
	b=1SqPB6Xisq+cNV+I5fmUtnHIGjcJiC+T8BLzXfm8j3pYlY0yODaAmDjf0Fcklj4mudZf
	 rk70GJGwAt/tsAj/bZ67iYQq+NQ5/Otyw5DP8NrvfSAQVd/ak7ZSz64yY/6yQO00Hh14C
	 KEa1K8fAYzpSl8K+TNsEsDh/1wVYP/H1ASWfpPZ0N62Dv97aB2OSsdUHjyjnlU9aMiFgX
	 ZxrIOzVdGiJ8e8bgSDnEOGqssmsUSxGgQS1I4napaUodYe1S4RAt+G9NR6zfFe51YSgRv
	 Dv4iJPA301HhQqHbRVXvw05KCRt1Rb9fd6u4YVcqlQmwSQu63kVcbGredwe6nqa4mPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182773;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=M4X8EpUHqfv+D/KtFEUiBKrjSDSsDwBeBxydBd3TeUs=;
	b=FQnPQ6f2u4l1/3g+2MYQj+1CXz4SIDK/jdJtazgBAFKFYKbiKnwB3MkBWdueywtJSZoX
	 G8nPlftd5B3wD0PlvBiChTa7qWCJ02NypO2vcXOg7il758PqVBBfsUUc+meO6qHxyMi+V
	 iJaNYLFAcecS59Dhf84xUdGuJvQEFVPLFngV3WrQsZsSxsNHbTPS+dLahYNiO5npncF8V
	 AIDndGZ+bpUreGYBVZ7X1OgadSMAnMg5/ikUFW7BPTYAiKg+OddxxSPYWgH9BPg3Cu7u8
	 jAcbILhcX6p9G+iXVCPXE6UORqYzsSuqD3z7ioOHBNWWqmw8sVY098xrx2NHOk+FYtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="TGt/Ka95";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4F0606A320
	for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 13:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TGt/Ka95
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A27581F000C0;
	Fri, 20 Nov 2026 13:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795182772;
	bh=M4X8EpUHqfv+D/KtFEUiBKrjSDSsDwBeBxydBd3TeUs=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=TGt/Ka95d74OSZLGYeQA6AxdtbJQQTf7CYHogT58hJDdAzVZWVs5dOOlIbBYXMwea
	 vJyBA4/iZ21TKWW8egy/e/M4TA/zlI6pdxqlK0dJdVPDLcFi2HxeE03PJHgHqPPBE3
	 0ZprKRPbtJixWu/baBqu1XDwYj1PlOAzhRcHsXYYr85ov77nZGhtn0AGUGA8ve7BnI
	 V4yxK5t5B9onJOMnH8diT47Mn5C47jDv89ZaxvUnA/2op2wiabxona/jzOt07BhCpj
	 axTuBOddg3+NIae9TsVSfZbX5Y1wUTkPnq5SGE38GJtme00vnl3b81NX9qx1A09I7H
	 j4+reuprUh5TQ==
Message-ID: <sashiko-outbox-225289@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/16] PCI: Make internal sizing and assignment
 functions static
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261120134716.3027-9-ilpo.jarvinen@linux.intel.com>
References: <20261120134716.3027-1-ilpo.jarvinen@linux.intel.com>
 <20261120134716.3027-9-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 13:52:52 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> __pci_bus_size_bridges() and __pci_bus_assign_resources() are no longer
> called outside of setup-bus.c. Make them static and remove their
> declarations from pci.h.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120134716.3027=
-1-ilpo.jarvinen@linux.intel.com?part=3D8

