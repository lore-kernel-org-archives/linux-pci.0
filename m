Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44517493631
	for <linux-pci@vger.kernel.org>; Thu,  8 Oct 2026 12:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791463304; cv=none; b=ThBQptW+Gt3Im8NJi0la4uxFc3fAQxHJOYC42b0rAWbgBBFE+bbu92S1Vaw49sySyOx0YCyyZ4axwg9sBp7sojKIG5cFW0f3YnGRRYNuS3CrL1WYlgw04Uuxnzc5dUdzsg2mV+xF+gZapPzZa707a/EA2gna5ClZWIjxKOxmdPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791463304; c=relaxed/simple;
	bh=6kNA7Lb1OaxhS40qdZ56sc+uBIsD7gC/QaiyrEHpQeE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=AkagUtrPqppPw31+hGkbl6lQvOhXOdUoOhjPvywKzqgl3/Q6j+lBNOGjChNFLY+oJtFjjFo1FdTQHwzV7aY5o0SwwA6DwJEojJSiVDKe9cx9KoWHNXekYhEVK6WCkeDBuMN4WF7Nj9rZ1u8MpKMFQuqiNzlWtJfyJoFmJk/RW4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVVXDYPt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVVXDYPt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E411F000FF;
	Thu,  8 Oct 2026 12:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791463303;
	bh=6U1r2AMkmZIxzAQe9Gy37yQAXjbBNmRyePKbf6QGLXo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JVVXDYPtHlww2L9u/LynqOVnVmBYhOR4UPWingq6ZcEM4C1atXbkf/fRBBT/gWPk4
	 WhNbw+uBNNDii6TziSGgEy0odDHlg2oCdoyT6kJ18RPUx3eZ/MnKMTsBgHyBamOuZX
	 tmNjizYupF+QmGmWqfT2QuPrshyU9mWmZPu99A22sHFOR+KTt4VNSrnXlP74ITbh8i
	 Xcx8wB0mSAt8QdieUlcDIjUszhgj1HP5fwFTVp27/I4owwKl+skg53cJxTAgOv4tUC
	 bGxXPt62VKI1rFn0Rulgs6G0UxZZC2j9ifPeSvaiY7UAfrB05PbI9h2syCm6Dyd1s5
	 LgwOKDQB1XqVw==
Message-ID: <sashiko-outbox-164168@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH for-linus] PCI/AER: Skip error recovery on false alarms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukas Wunner" <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <0552ed277e40a288e0157af799257ee6ec722534.1791460615.git.lukas@wunner.de>
References: <0552ed277e40a288e0157af799257ee6ec722534.1791460615.git.lukas@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 12:41:42 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Alex is seeing a probe failure of the amdgpu driver after the Root Port
> above an AMD Navi10 GPU has been reset.  The reset was performed to
> recover from a Firmware First reported Fatal Error.
>=20
> However all status registers in the Root Port's AER Extended Capability
> are blank, so apparently the platform firmware raised a false alarm.
>=20
> The issue is only occurring since commit eddba19b8b5f ("PCI/AER: Support
> Advisory Non-Fatal Errors").  It looks like enabling Advisory Non-Fatal
> Errors causes code paths to be exercised in platform firmware which
> were never validated before.
>=20
> Skip error recovery on false alarms, i.e. if no unmasked errors were
> actually signaled.
>=20
> Note that this will also skip recovery if both the Status and Mask
> registers are "all ones", as would be the case for inaccessible devices.
> However that seems justified because it would imply either a hot-unplug
> event or a Surprise Down Error further up in the hierarchy.  Interfering
> with recovery from that seems uncalled for.
>=20
> Fixes: eddba19b8b5f ("PCI/AER: Support Advisory Non-Fatal Errors")
> Reported-by: Alex Deucher <alexander.deucher@amd.com>
> Tested-by: Alex Deucher <alexander.deucher@amd.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D222095
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/0552ed277e40a288e01=
57af799257ee6ec722534.1791460615.git.lukas@wunner.de?part=3D1

