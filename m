Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864343C062C
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 21:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783719444; cv=none; b=oJAxpjmy5RmioapfSC5FgJ5I7+BhFu9iszpJpOoQhKrylFZgJ9Jp1chVLOJoHiU7+AdVgJC9IYFcmtZnpVMb2h+PL2wSOXmrb8/F4N0y3NE1nuH8F+KFgBqamvMhkiT/wsCw8UVqQo4CWbs2wWqNcOnOxnZZ9bv6GJC/QFOynF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783719444; c=relaxed/simple;
	bh=QCIh5FcMAqpFprpSjsbSP1JGlqz/2b8iY93s3fqx77A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vwt9rAV8sCOuOEhobNOaV1/srCSWX0fRUqRbNR/DZZFrgOTS00mQeFpEPpS4/6lhBmRMGXgC8dFeB6R4ndxkRdspzXVCE0hxHjjCdn+ifsBR1pm8WreeKAfMVOn5hS+184bSuVwd25Cp8kYo6xmUjty4NPE9h046A1jT7kAnV0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbtLWtf8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbtLWtf8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F31871F00A3A;
	Fri, 10 Jul 2026 21:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783719443;
	bh=QCIh5FcMAqpFprpSjsbSP1JGlqz/2b8iY93s3fqx77A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZbtLWtf8p2Kprjj2CDGw4whTp01db5xS7KdgeG32ZJiLdAH5ovTQ9fCdN9OLkyZ6i
	 zGKJrT6nfa93SdycDHDVFGIcAygmiMioIsjl7gRfJkYyjS/5ZWdo73gILEdoXoBFNb
	 xGz9SjVnMTROeGk0MOyukbFfYFalR5Di3OBE5vqw5ZXt80CXu9GTZPwufOtQAg9/NA
	 gggipRgyetc1HzB3Gb2goRUANw5ePCbIRvb9Iyrm5HkeYonFxVusAFYkRzU1DwYa3p
	 tjUJGdzIXp3UzthI2qK+6eAsR+VGg2yMHQ/edvyzJ6IM4Qj93ofHQm7mpKH3tu0TGk
	 NZjoIUH/UrGQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 12/12] Documentation: PCI: Add documentation for Live
 Update
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260710212616.1351130-13-dmatlack@google.com>
References: <20260710212616.1351130-1-dmatlack@google.com>
 <20260710212616.1351130-13-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 21:37:22 +0000
Message-Id: <20260710213722.F31871F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add documentation files for the PCI subsystem's participation in Live
> Update.
>=20
> These documentation files are generated from the kernel-doc comments
> in the PCI Live Update source code. They describe the File-Lifecycle
> Bound (FLB) API, the device tracking API, and the specific policies
> applied to preserved devices (such as bus number inheritance and bus
> mastering preservation).
>=20
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710212616.1351=
130-1-dmatlack@google.com?part=3D12

