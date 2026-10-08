Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4B63BED7D;
	Thu,  8 Oct 2026 06:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791439909; cv=none; b=teEZm84GX1R8tbtAcEL7kl0oPqcB0ucJMTSSFlLzfHy4zo4kiAQRUHPWvpWXfmfDseBSPEp7ayu1PyCVU3yJPi6OfyVRGOdQ3NaKGImEKOtyr249SttwZI36V59K/yKl9xh7OCR3kRKYqfBExMCMkNaW9kcvBjcnXcM+XxO8VBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791439909; c=relaxed/simple;
	bh=8jezOMMkGFCztxlditv8YLGj50mHKbfGsl1Giq1mHXc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ufq85q8AuPX3HACMsOCLhtOZBbogr4x/KhfOTYYKXep1OniQRu9uujTm7VXrQzJOvtOu7Ia+CJ++RUdw4VOEmigI79SYPaUqA7lIhXOREdTOL4UlTf+Mzndujr8T/McOBElR4OQ/F40+Ql6GTArXT3l07FHSSEg/NtxyifpZq6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VT8ibXfO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VT8ibXfO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 791CC1F000FF;
	Thu,  8 Oct 2026 06:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791439908;
	bh=8jezOMMkGFCztxlditv8YLGj50mHKbfGsl1Giq1mHXc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VT8ibXfObHsD1BPk2SAzr46nRDRW9i9wUZJDzgXlRnhJ1XcW7pIj+8Qmi6LYUQ987
	 j+SmalyjV3qo55E/f6IyvcaPPgEiATI7Hzvy5muDYBF5iT1jmjMUXBOHEF6ZKkmotN
	 DcOINRszHJYJ9CFG3wbmQ9Uxt8WZij2E3wyE9JcqGburoJ9rr7Xh+qHQsZfdiuASMa
	 mTbzRad30YuDpXfsDtWDQnL7sZTPBDCSRMFBgkxtU3o9cMte4sh5dEQolrxx8acdyf
	 q57sXkH+68V+GrqZbu0gWYBee3HnBHQLfiAeSoeiXrQbupqmlsyKYLuqghW7UnyfCs
	 p0B3yGRQveyXg==
Message-ID: <sashiko-outbox-163669@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 11/16] PCI/TSM: Remove the legacy guest request
 interface
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261008055955.4014342-12-aneesh.kumar@kernel.org>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
 <20261008055955.4014342-12-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 06:11:47 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Guest TSM requests can now be dispatched through the IOMMUFD vdevice
> operation. Remove the PCI-device-based guest request entry point, its
> scope enum and the corresponding PCI/TSM driver callback.
>=20
>=20
> Cc: bhelgaas@google.com
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008055955.4014=
342-1-aneesh.kumar@kernel.org?part=3D11

