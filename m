Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1590E40D59E;
	Thu, 18 Jun 2026 22:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781820286; cv=none; b=Bk9a1gDGkkTPn22/5MZPA4ypqeXwIjK5h9A3fxe0NegexmfQr8TCHkRq2Tkgt+HoC2iR+LeHOkjej0roKaK/XSjYoM5w6mGWbKa+Ibxyaeh9wtJQP+f+SynZmImNgFVGqiE3kkEb0HMYM4ZiMOfFrfwe92wPPVKhM8Op5ZPUhkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781820286; c=relaxed/simple;
	bh=2ik/9Dzth8p8mMFYQFTL60M6pYmTTYp92u7kp8vqa90=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nROZjS53humJKYe6sD0bXV05CNODYozUJL8sFSyVKr6e39mIz6W6xd7u/N2nWD4NEMNoY37Fs2b7Ier+PmBXSvjA9Sm2Pan2oh3u9m0chFZ5qPKRtu78Uisxvc0lfEnqmzSr7pvQIhdhmInJVaK7eEm2SZvUMoHWVR9r5oLjtlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fyb9u+0Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fyb9u+0Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F3E01F000E9;
	Thu, 18 Jun 2026 22:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781820284;
	bh=2ik/9Dzth8p8mMFYQFTL60M6pYmTTYp92u7kp8vqa90=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fyb9u+0ZKksiMiDPKmsnTP+8JdoPO8/mlUVf6RlFtS8IOd/cj6WqlaT/U5C/8zbEB
	 2g+pTwcUARIOysBqbCQAsS2GTgUZNl0CoM3fy4rrAZ4upLwVhKqKyz867fxlHtI+aJ
	 NMf9ar2g25CTdsoAbyM1iGyccaN7x/skXIasGnDS62juZUgCJTLaLvPN3ZfhkwCq9r
	 qZEYOr+g1qccHVgTW1Edq3zsXGq55ykILenOtqQc3BtE48P6yvSlMWCFt1MKx2gv/i
	 Rnd1b/aNS4kwyqQID9Q5sWHsBWGnKcAnUDaH17jmg7fjSoAOS4xQephD+lROTd+uiW
	 sC/npfVP2J7mg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] PCI: qcom: Add support for Hawi
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matthew Leung" <matthew.leung@oss.qualcomm.com>
Cc: conor+dt@kernel.org, robh@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260618-hawi-pcie-v3-2-f31880bfb3ec@oss.qualcomm.com>
References: <20260618-hawi-pcie-v3-0-f31880bfb3ec@oss.qualcomm.com>
 <20260618-hawi-pcie-v3-2-f31880bfb3ec@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 22:04:44 +0000
Message-Id: <20260618220444.6F3E01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add support for the Hawi platform which has two PCIe controllers: one
> capable of Gen3 x2 operation and one capable of Gen4 x1 operation.
>=20
> Signed-off-by: Matthew Leung <matthew.leung@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-hawi-pcie-=
v3-0-f31880bfb3ec@oss.qualcomm.com?part=3D2

