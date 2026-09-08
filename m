Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA155437F2;
	Tue,  8 Sep 2026 14:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788877113; cv=none; b=LhxKgPxx4PX0XStw+ghSIdjvOuSZfYJ4S2601bCIfSM4bZlrCbMZ+yo6N3ibylYY0vEc67hVLxQT88iSDWXFnQvdn2ySni2qb+1jQqD5tkSEtN8EJpCBaYtTuOYganfAYavvhA4CVRCEX4iFaw3xHwKJDZryffur7zHNBANJTtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788877113; c=relaxed/simple;
	bh=J3Y5pgDriL/N8MzvKIWOqhwidYcVe2Y4e8MrbZFUhuA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m4hxhtlD7B7+c3c8kKvUBOwww4JajnuXak36SEIDVPyS++8Ur5hTs8+5BAAXjqpjtfLW33ZbE7WZ2pcJliDYXP+pGqBqFJycFAfhFHVOdkXfrwXTmiw8OhIA5lmDFqVa8zxfc4Vwn/vA7dIzgdYdyJWcjHR4NQAojZtmCsfc5ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRh5FeGL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRh5FeGL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23BC81F00A3E;
	Tue,  8 Sep 2026 14:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788877107;
	bh=J3Y5pgDriL/N8MzvKIWOqhwidYcVe2Y4e8MrbZFUhuA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PRh5FeGL97xIWG8nMhvC4ytM+/TZyN19XUaElYkwJFRYS9/ISmZyNKo++Jpan9WlH
	 OhC1BdRBdIx6OkI639om5szrrAn2sIQ60WNTOpXfu9urxKbQD0nANMGIoNNFy+BWh6
	 kfPi478XR9DHGa59tTOn6zQtac5ckZuPXybJm10iapxn4uEGnNHYdRKFbDrzXxBhS0
	 nc54nCn0f2aNKEnQGaFU8MziVvvBnTKMYDEGTTVwBqDyvSB/eao1j6BeEQPUSBPjOL
	 tvKTtnh7R8JiZYoz0x8QYL6ugBu8VHLCxSC1aVP01DPmPXc+O7LUJOelqfrHs44XLu
	 crHC+h10JOZ6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/8] perf hisi-ptt: Abstract trace data buf and
 offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sizhe Liu" <liusizhe5@huawei.com>
Cc: linux-pci@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260908140509.2485649-2-liusizhe5@huawei.com>
References: <20260908140509.2485649-1-liusizhe5@huawei.com>
 <20260908140509.2485649-2-liusizhe5@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 14:18:26 +0000
Message-Id: <20260908141827.23BC81F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Abstract the base address, current offset, length and packet type of
> analysing trace data into structure hisi_ptt_pkt_buf and move the step
> of current offset into the corresponding functions.
>=20
> Reviewed-by: Yushan Wang <wangyushan12@huawei.com>
> Signed-off-by: Sizhe Liu <liusizhe5@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908140509.2485=
649-1-liusizhe5@huawei.com?part=3D1

