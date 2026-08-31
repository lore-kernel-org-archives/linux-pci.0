Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7753C3F67;
	Mon, 31 Aug 2026 07:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788161369; cv=none; b=lPCJatbR+ggctqgSNZ562z4ehAL8q2Q0lZ9lSab6UHx8o7E9BA/dqGjcchB9UoipIGZ4QWo4I3evkSY7gMwNfv10LdozMPz0Avn3TIkQXgHQERRstqjkwsizBdud5JUOVUiH/X49gDAPGydyxjcA+KrgsioR9Sc7SpkVJlEmXWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788161369; c=relaxed/simple;
	bh=pGqwywBqlZf7Zwd5zCQtqG1uwRqmnN3TwFbLRAPhidA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fHWuoHRLp0QkUMFBT60mW7gAe+wRDISm6yNck7LFUgWbyMLWu0janmqycDy1ZkYLA6jfYTpPRWpmGJVYzNSyt7gL4btw6TsrK6CvWKFgur3EHOrNW7cNFVtQzljurc+gyFTDHDMCijA5cKwhKvJ/0F2us9KcqmS8VuDRhqVbO30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9suHZ7n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9suHZ7n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815791F00A3D;
	Mon, 31 Aug 2026 07:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788161367;
	bh=pGqwywBqlZf7Zwd5zCQtqG1uwRqmnN3TwFbLRAPhidA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j9suHZ7nnOrg9E6RaZKgl+uxxR8F/mPgGsNn+PEd/BhCERgXwUFIqixV9pzfw8MvY
	 WHFvH3UoiC3xSmLOPCp9MFQJYRFaqaX6NEPM6HgqAed/+kzjXDjfm1paCd1+UjJvLn
	 aPjbMOgLEZcFEvsjzy1j8k2BqovVOtDwl3He9K1oOq3uoKPame1SWgQrnkCZ47r/My
	 PBAOj5WEXtHjbFpgjNcbaou9NQLxx8abIuM/Yau87K3xTUXsXPzyPoQ92BKKchZMpC
	 PbFta06OURvY1NWjMox4uHSswIDS/ozhD9PgLr6I5q2qXXmAIxkfMjYjQQpD7+oKEN
	 08nUkmfUJI3yQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/5] PCI: qcom: Add support for Shikra
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sushrut Shree Trivedi" <sushrut.trivedi@oss.qualcomm.com>
Cc: vkoul@kernel.org, linux-phy@lists.infradead.org, conor+dt@kernel.org, robh@kernel.org, linux-pci@vger.kernel.org, olteanv@gmail.com, neil.armstrong@linaro.org, devicetree@vger.kernel.org
In-Reply-To: <20260831-shikra-upstream-v2-3-406661d75afa@oss.qualcomm.com>
References: <20260831-shikra-upstream-v2-0-406661d75afa@oss.qualcomm.com>
 <20260831-shikra-upstream-v2-3-406661d75afa@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 07:29:27 +0000
Message-Id: <20260831072927.815791F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add support for the single PCIe controller on Shikra platform
> which is capable of Gen2x1 operation.
>=20
> Signed-off-by: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-shikra-ups=
tream-v2-0-406661d75afa@oss.qualcomm.com?part=3D3

