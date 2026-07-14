Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9926520ADF8;
	Tue, 14 Jul 2026 11:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784027868; cv=none; b=LL8aXBFzyuN9qGJE7tarB2cVCmGYHNDOw1gnQQCt0ALGyQesEc5HIBzqTXO9T28wp8FdK3KOjyVbHUDBW2lskzCCpKr6W4/1EkADdUf5QdbQ3WtZwt/KSRA3d5aB6GfIqAQlrG4zeYjlk1et2iOLQcf3UCkfx7QIAh1euai7dL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784027868; c=relaxed/simple;
	bh=y86nbtwQBh3ezVC6JOdzix8ZnIO8vkY/q6esD6sxpK8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jMd6QcSPddrOBUJNVr8gjBF527sPrQVxV6AipSpKWmPfPYSbTrKH/mrBanEdDQVM4nnzbt+2qYwM2ryZzAvFltXD4SDrNXh7ceDOfC3gMYQpT1xy6ijnWOnk91FCDi2X/oTErkerhV5fNOv6rfseFqcbQl80ezL+jDoqHHvF6WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWju67Rx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWju67Rx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 199FA1F000E9;
	Tue, 14 Jul 2026 11:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784027867;
	bh=y86nbtwQBh3ezVC6JOdzix8ZnIO8vkY/q6esD6sxpK8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oWju67Rxdz82iahBFKNpYpVjvTpKHpe0cNWSs821/0ik6uiGAf5NAJPwIak9PJbWx
	 Ysls6pWW+sYd2BH2Uz3x2D9X9J1QlNaA3E+QIzaQfbcf0tTxh5OqTNDrLCwGArkdEy
	 k9MXidBtcrahLM/XBppdGad4bsE36tAPv0BiDOCaswCtRHWLy8CxDMnhgZtzSxWcOl
	 /W1+EgTkgsqhu51+D+lsCRGgBzAIdfF4CNgPTl5iTHAmuJYYNA4abVn8r3r9uYQDu8
	 Znex/vdE+WamXVCQK4EvffyuJGKApLa/3iHWs+7ON0NvQJo88Vgu4ZhU4uVMZjHEmt
	 79TbvorqmHZaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 16/16] vfio/pci: Expose per-device TPH state via
 debugfs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260714104325.54444-17-fengchengwen@huawei.com>
References: <20260714104325.54444-1-fengchengwen@huawei.com>
 <20260714104325.54444-17-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 11:17:46 +0000
Message-Id: <20260714111747.199FA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add read-only debugfs file "tph" to report per-device TPH runtime state:
> - effective tph_policy mode
> - virtual TPH capability value
> - tph_opt-in user enable state
>=20
> Align debugfs comments to include tph_policy and new tph debug entry.
>=20
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714104325.5444=
4-1-fengchengwen@huawei.com?part=3D16

