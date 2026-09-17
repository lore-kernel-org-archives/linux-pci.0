Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A446449B45C;
	Thu, 17 Sep 2026 10:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789641193; cv=none; b=nbi534H/So4OQaRTFyEXXnxa/xhEBBzVMMLoJgSnLC8gg03ab99MdX11W1ifjHjhsQngmUSx8MYZUvOSgXjfxYfXWXI95PLn1+zPMroN53wQam72UzneAYoYj6Tnqc81GKc/IwU1aGg8JcJ3BqL+fNCi95v9zBuVQNaGdOv1LVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789641193; c=relaxed/simple;
	bh=4DflvYx54z6lSDMTa16zjZJMQHdRgsZY1TNulXV35yc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qD+qgwOfqRBfX8XTG5UPZz5R+5z6RJ6cEpipVA7hWGPiMXzsAmIUHXpvXW6U8eTZiOiivzz1qpSpTjQSnYO6KFuKKjxHI5X6b54WXBSZWZR2mtFc4aidcxmewZ8bj+saQMLYzvrtfVYhkEpMtbDzGROhfVKWtXXCogiRyA+PyCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDzBjkIy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDzBjkIy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFDB1F000FF;
	Thu, 17 Sep 2026 10:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789641186;
	bh=4DflvYx54z6lSDMTa16zjZJMQHdRgsZY1TNulXV35yc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XDzBjkIya6XdQ801dIoJS6twKSMPBPFY/2RAS3rFtDpNHbdfKaBiimsjrl7xBJ1iP
	 uHrXj5P23YWvBSvl/4yiui4SO5MSrsn2xOt9MllhM7pbEky4vrAdn1cj54Gk4Vw+ox
	 6OEqcc7F5C1bagoc4BJJwQrVVfRbvT4mayS9UOSjrU/wHJIGU+z57KrwE39NMamIPi
	 PqaOyhxmWp7kXNZD/EK/RSo9pqAzwh6yrej1/AOifIgcFW6O7xnh1pG9dhwAYsjZ7l
	 Wi/gM7Pjl/x+0zyrOWFuYXZulkSX1gI/Nb62B5FfplZGVY5D1Cm3kvHUW1gp6M2GIM
	 6mT6uZA2XgBww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] dmaengine: dw-edma: Sort Register Field Macros
 by Bit Position
Reply-To: sashiko-reviews@lists.linux.dev
To: "Devendra K Verma" <devverma@amd.com>
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260917103050.1020982-2-devverma@amd.com>
References: <20260917103050.1020982-1-devverma@amd.com>
 <20260917103050.1020982-2-devverma@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 10:33:05 +0000
Message-Id: <20260917103305.CCFDB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Sort register field macros by bit position to improve readability.
> No functional change.
>=20
> Signed-off-by: Devendra K Verma <devverma@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917103050.1020=
982-1-devverma@amd.com?part=3D1

