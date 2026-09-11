Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD2812AAF1
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 23:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789170161; cv=none; b=le+DpSH7O+NWr4qADCo+RQApnw/y4kSa7mq48ho+tp5Y+ViaSlgQtO+O8YrsEDELYWXhoe1GgerzwGQeFhvEyIfEstgvsQ7jueCjtF+5Lta5tONDAQC/GcUpHAnk9FF7J66VHO+UNTds1tDWBbXNmpq2Jr+eJKtkpaLRRLygJO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789170161; c=relaxed/simple;
	bh=aEwl5L//Z7uru9XoQ5WlynPJk12WMVNX5rx8DpyC9hM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TMMEmW5E6BnBar8RvgCyd74LplkhWXx6x2nlbSi+BgkGnk8XWTkySLleB4T4mEB0hoEF1RjFJvjmjS1zTgTdzQHZEdwQaIfYjmtesXUDAJUfRCJc7bjmRP6FIQHvctF+3qPLvTv/q1q6EMlVLBfqpI8oCfMHqzbTruKu/Jt+n1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqNUZrKW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqNUZrKW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B311F000FF;
	Fri, 11 Sep 2026 23:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789170160;
	bh=aEwl5L//Z7uru9XoQ5WlynPJk12WMVNX5rx8DpyC9hM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lqNUZrKWovZfhEm1B4dJ1ywWfu0rUUlAuM6zTmoC/VbnR0K4QDepdE6meluQG1gYm
	 ZPOwxrK0exaObnYw+ZaH3NsJjR/bXenJRrZNZFkwCK+StiBgtYLIKYrrJ2puzppG/A
	 yVvII1MSKFau0wbG+b4aBBXNpmkxB+2eZG+GGEjYEyF9NXiwvoEXfVv6yUYgI36UD1
	 ysqTBtRhqsoq0FhZY3zhZRINOkuvLzikMaSZTGvV7nwxPoSjcEWaiMhg6QF7mkjMzv
	 plFU8HBaIYfhXA1OZ/8jkEZwNpKPT6j9Bnh//9YpZwD2tJTPcPoF9iGgZHbIiZtest
	 aSjk+pa5e6nBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/13] PCI: brcmstb: Declare and assign quirk
 EARLY_PERST_ASSERT
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Quinlan" <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260911233541.1650895-10-james.quinlan@broadcom.com>
References: <20260911233541.1650895-1-james.quinlan@broadcom.com>
 <20260911233541.1650895-10-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 23:42:39 +0000
Message-Id: <20260911234240.01B311F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Declare and assign a quirk where PERST# must be asserted prior to an
> internal bus being turned on.
>=20
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911233541.1650=
895-1-james.quinlan@broadcom.com?part=3D9

