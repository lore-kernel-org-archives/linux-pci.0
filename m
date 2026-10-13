Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B702B3C8C71;
	Tue, 13 Oct 2026 17:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912655; cv=none; b=j8ICq3p7ZJmgIjr/fvtEawNF6boKn+KJHPZCDGSlys06R+DV66n0+Eb5ZMnORLmz2mp88dJRp8y7r1ufDycsfG5mYoRO6iZSl7sfIfp3nBtpSafU67Boj4OiHYJn7RfzEn/KTjKTRU7aoVqliijn8kgdV7FEEXUlqms+3OFED28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912655; c=relaxed/simple;
	bh=VvIIH0l1RNOFTaWfZtFrJMXf34bXx5XdfsWF92dkpdk=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=e7e1ranUOZ011d0cZ69f5FXPklH5NbVIwxYpSvmMy7TcsAhENwsmhwZFteM0tdLQVeJxY4JfDJfe1xu+UHgsUwggdoPp0evT0xL0F5kJCY8tS4B8Y0aK39W1tiARMyOeIDS+66i+iUDBIoPWtDXZOEk0aEz4DdvN4C0rO8pdh5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXvHfUqm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXvHfUqm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 285811F000FF;
	Tue, 13 Oct 2026 17:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791912654;
	bh=VvIIH0l1RNOFTaWfZtFrJMXf34bXx5XdfsWF92dkpdk=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=ZXvHfUqmTdohdlcD4iCKsx0N1RYbfR+GCDVrQg5kRI7/fYJY9m9t8kg1Zd/QHZGjI
	 /IVOyocUr9IGega9WKatwP4WBKaXVxY9cGcOZ+y8zBlznp1QCTZ/AK3f8FY2XtWXWR
	 lxVEVEDEhXV7+UK+rn3Y9bi5C2Zm/BCkYGS0oeEhZboFNMlvPBrfQ1fFYOPQYmnZtc
	 k1q12+ycBoOF8/9oEUm66/rbfkh6uP5W/0/erOrYXqa2HvTremYeWTbktO9Y4A/I1S
	 s8VgmOTt/dVnY8ZZcrhJswEIndHFah3FjbXg6aWaLlJP11Ekc7hbrNs1oQbDYyE2kA
	 2fWrb+Q+yVMrw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 07/10] PCI: dw-rockchip: Add pme_turn_off support
From: Manivannan Sadhasivam <mani@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pci@vger.kernel.org
In-Reply-To: <20260908150958.337E81F00A3D@smtp.kernel.org>
References: <20260908-rockchip-pcie-system-suspend-v6-0-fbabcca9921b@collabora.com>
 <20260908-rockchip-pcie-system-suspend-v6-7-fbabcca9921b@collabora.com>
 <20260908150958.337E81F00A3D@smtp.kernel.org>
Date: Tue, 13 Oct 2026 23:00:49 +0530
Message-Id: <179191264913.12828.5893567241322450639.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=459; i=mani@kernel.org;
 h=from:subject:message-id; bh=VvIIH0l1RNOFTaWfZtFrJMXf34bXx5XdfsWF92dkpdk=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqzmrM+dmU3OD1jfGqcrpNQZj6RB6pZY0fRFIbo
 8sXIu9RS2OJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCas5qzAAKCRBVnxHm/pHO
 9eFLB/4+jooTQGXPqLVsapK1jjw2jcqDnPE7iryWC7qPtUMmDKoKmlII66f1SNZzSsPm/FOerbO
 Qe2eAej83Bob5e/vovFE8siQfKx8bTu0gUMfNm9o4/Rio7ETkDP4ly62PbQXpuOtNcYxAgf4+Iu
 j3otfX1gsaiMz4EGcxXFOXeGwI6OWPH4b5p1k52TItI+og4b34EFA+G9kHmLP9DHSveXlPUsjSS
 fN0/Cla1tNU0zseolcJ3Edue6Jc44/5jLRCpO9sJhlCIfEXuNTjfhQUgNA2iz5VqwEzA1NwTLEA
 08IYNdY8bxd08jiuUAebKBrLT6obGL0Mgli6X8oiNj/IFHmy
X-Developer-Key: i=mani@kernel.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-09-08 15:09 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] Incorrect use of FIELD_PREP_WM16() on a Write-1-to-Clear (W1C) interrupt status register, causing unintended clearing of bit 25.
> - [Low] Redundant macro definition for the Power Management Control Register.

These issues seem to be valid. Alteast, the duplicate macro for sure.

- Mani

