Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74B92E7F38;
	Thu,  9 Jul 2026 04:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783569985; cv=none; b=OyWvll3qu5u5Tpz3sIWgA5cd+f+fb1SR2vNzH14dw1t4eNWmctXr0MvhtfRLMBO/4Pgr72cz/hlqWyWGlJUXwqVMaaIUAWdLUTwI1+uiaO59WJt9pEI6+ulJlJq25Ufe59/OCR3/QZ8osgyox2JqpmD4h6O3CIoJb9BtHaihLFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783569985; c=relaxed/simple;
	bh=GiBlHpc448tYDox8bI/7ElvrJ5wXfhaGwNdG3L7qjDQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IjE6mj0tEcyTT0JuDxb4f7OKnAwNr9YCs5bOCg6i71sVhilo8ngeXiGOXmOCJP1HiPror9dXouq2O+nCu+QHGDHfGdHty1Cqn5kQmiIAKsFCDdtFARMjno/q2bKHrWsvBSsNr8nzgRauURbtwu/G4W+aZMpeCm2eYDWzAjdOoiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEBVZYm/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEBVZYm/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085081F000E9;
	Thu,  9 Jul 2026 04:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783569984;
	bh=GiBlHpc448tYDox8bI/7ElvrJ5wXfhaGwNdG3L7qjDQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fEBVZYm/WdwFiZqCbYExqU7Nxg/lBkssOsvnm1WGyMnZdqp0YbLxP8fzt+LUZJQ3e
	 3/Eq7UccOrWfCsdQPJeXS4w0+8T4lQxM6o6ksMoFELhOJNbGEG2GOic6DvT3QqLRKU
	 F1wM2FnRoBODCYxSFp3PNO5ScIWkHXrJ/U8nPSwMYAmi+HVEAFomlv4yTKa4n5Foiy
	 5DthkApDu/blxxi9wAauwYEG4xRBHcGsgCsXVXbW6xhBhz2vG7AneVxWfzyVPJXNge
	 uQm2smZ0MwHFgGZhlHuMsEa2htWFTQkQYPdVo2bYWgiUYrWEPKRFECxFJyq/KS0W+y
	 T6/DdBBCemqzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/6] PCI: spacemit-k1: Add device id update helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: conor+dt@kernel.org, linux-pci@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260709040027.958400-4-inochiama@gmail.com>
References: <20260709040027.958400-1-inochiama@gmail.com>
 <20260709040027.958400-4-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 04:06:23 +0000
Message-Id: <20260709040624.085081F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Both K1 and K3 needs to set vendor id and device id, add a helper function
> to simplify this.
>=20
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709040027.9584=
00-1-inochiama@gmail.com?part=3D3

