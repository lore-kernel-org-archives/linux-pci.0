Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A724908D1;
	Sat,  5 Sep 2026 12:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788612423; cv=none; b=Xce/aVzPMIS3DOurh2/4f3cqo5Mrp3ru7oamJxQ8Ks50V8Qh/UvYNT4t6Ax6PTZY0hPeOOHCklq8DRiFjwETc67wmOCr1ExcNkqkBep1AnPk+EqZYgWXnmWPVJt84CnwPMUh2k/RFjtmOIB4FZsH4Dg1zHBleS6fCGb37gzQyZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788612423; c=relaxed/simple;
	bh=hu0YpqK2RBmrjhXy9cH0DI0PS/BsHWPmwn5i5Kzfwh0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LzoLGZzyCFiVPi0i5Dven0YfBI5LvD3tzNLUKe1xO7ihYEbzpE5HDveuAnA2Pml+QY559+atUvbGIvCN1Wam3O0b9xGENTP2sVqibROb4PlA3hpKmG2u3l7QPUI7El3O9Q1WfZal//l3THei8d81uXuUw1qLQhUPUoM0P8oXW1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgPkPVCJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgPkPVCJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57B21F00A3D;
	Sat,  5 Sep 2026 12:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788612422;
	bh=hu0YpqK2RBmrjhXy9cH0DI0PS/BsHWPmwn5i5Kzfwh0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dgPkPVCJgfS1siZbyAN8pmhixoNTLIFCBdSq+0RdfHGVwe6wQwrFs32xTp6PRw7Qx
	 z4PLZ4CjQ8IlMGJbQrOhyL0AVOpHp6/9ki77VyRxoZyNJ0yHm75SBFsCzqWe9fwFj2
	 SrkvH+ryCj201T1i+NQTbIRL9qXDTlqGBYToiUvNz8PWV5d4u+k9JYfte0alDDSNVo
	 aFAJ+5Z+DN2bkN+4VwXos4cGjpc8SyV/KPuUtCcfogZalJOuX7NUrePpLoz0LbMLiE
	 fkhc4v57cMLqYTABkj7Dqd8PmhpcokQyksCYhIC+R67bqOCqCG45xbjFZI1ubW4oaA
	 T/hzjRfV1KwFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/3] regulator: mtk-spmi: fix Makefile typo for
 mt6316
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Rodrigues Alves" <breno3011alves@gmail.com>
Cc: media-ci@linuxtv.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-clk@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260905124434.6163-2-breno3011alves@gmail.com>
References: <20260905124434.6163-1-breno3011alves@gmail.com>
 <20260905124434.6163-2-breno3011alves@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 12:47:01 +0000
Message-Id: <20260905124701.D57B21F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Fix a Makefile typo that incorrectly placed the mt6316-regulator object
> under the old CONFIG_REGULATOR_MT6315 configuration flag.
>=20
> Assisted-by: OpenCode AI
> Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905124434.6163=
-1-breno3011alves@gmail.com?part=3D2

