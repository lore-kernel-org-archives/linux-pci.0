Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C836533B96B
	for <linux-pci@vger.kernel.org>; Thu,  4 Jun 2026 20:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780604418; cv=none; b=M/b/Jvm0lh9BTPb7nLk2SlPqvW7IuTQcokxE+DOrQe5STld2GY2nsoHKp8DC6yBbJNrzrHh5hEawPDMkKtz1s6mu+rIxTrguVuH/7PB5dJ9d7bJcFkELBa+z59X64RIMGe3rmxjNKbneT434ZKqq4a5GQCb8gEMtCWhHb5LamWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780604418; c=relaxed/simple;
	bh=bGxZFbUliXuOot/Y2cFjMm1EYrL2vkwCUoNyO2rpOtE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YSHABM0x7QppcDu+xqvBuGHtJOdqtl7RM3cRXs89GjYR/ezWxdQ6ETISBPBGupZSyS3sO9DjoWQk4wZTObmUZls6nzGogvuZOQXTnWjOhISMaYW6JEh9kAOjyXk1LwcJQbgKOlK9EEVj/cAymvzaB2kdE9loBwamNMBQqHp9yoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9G/XZZS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9G/XZZS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E191F00893;
	Thu,  4 Jun 2026 20:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780604417;
	bh=bGxZFbUliXuOot/Y2cFjMm1EYrL2vkwCUoNyO2rpOtE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S9G/XZZSwvyXiTkoSdzWuZ9Sdvv4nqWcGbt+WlUzCUMZaLAoA0LADqP7zb78H30W/
	 WZ/LJOngXs0VhrP+fAxa9IMAWX/eUArsxHO/Lxuaw4FBSHHr2K72cxaN1vRQW+HwjC
	 HZRFSgtmkU1VheaWQ8P4m+lMY2Kp5qmE5iRsY0/823F7KzdhcrVAT2v3Km6dp2O6aM
	 rMWLE3VPvV7sx7I0h/GATXDmGawdT1HYpj7aouLqZ1IwbbUFskuE0/KbN9oppZjU6X
	 DhMJQ+iGs+aM3NbTNjYpWqUpvRGAkp09aR38rh8a3ormdvb/P/NXOyzooSaFjbp9yc
	 QLQ0LxOSBGOQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 08/10] rust: aref: update formatting of use
 statements
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260604-unique-ref-v17-8-7b4c3d2930b9@kernel.org>
References: <20260604-unique-ref-v17-8-7b4c3d2930b9@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 20:20:16 +0000
Message-Id: <20260604202017.33E191F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Typo in the commit message: 'if' instead of 'of'.
--

commit 903f28665e4d9847cce4458bdb8092b6304d076a
Author: Andreas Hindborg <a.hindborg@kernel.org>

rust: aref: update formatting of use statements

This commit updates the formatting of the use statements in the aref.rs
module. It expands a single-line use statement into a multi-line format
to prepare for upcoming changes.

> Update formatting if use statements in preparation for next commit.

[Severity: Low]
This isn't a bug, but there is a typo in this sentence ("if" instead of
"of").

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604-unique-ref=
-v17-0-7b4c3d2930b9@kernel.org?part=3D8
