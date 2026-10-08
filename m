Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EBA37C0F0;
	Thu,  8 Oct 2026 06:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791440193; cv=none; b=cMlxKY390MDXThMe7WEaJf0hPHK5+YZC5MTosTxAY8+jbBBNGduB8EglGKGpSnWMFsRK6F+bTogbzjX0rwf9mVZapuaR/oX6E7/kjPazLV+bQZtgb+3YU9OoMSvY6UrBvyudKjMCZVa32KmTsWOjd1tfdxzX8ohaNXvCljXhD18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791440193; c=relaxed/simple;
	bh=VIaRu7Bi0ZULlYw78hZ2+A5jvRn+EJrhV04S5+gm7Ug=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=GVEwjjRCyNVqiyWubb765/lyUd9vDJmBZExaS9zTmCKcU5q6fjYIpVTJ5TnsLwVqO0Xz9wbKEINz9ojouaxLbObSCHNs+39s99YCa9uqXsu44k0Xyjq+YgFPuRVuySnXyiXWaoCvhz3mnFJ+7fuRbSvHVxf0qCJ422Nw8fp4Hp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQn8803X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQn8803X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0DE81F000FF;
	Thu,  8 Oct 2026 06:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791440192;
	bh=VIaRu7Bi0ZULlYw78hZ2+A5jvRn+EJrhV04S5+gm7Ug=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OQn8803XgplQ8M0CveQgiyF3W7Tx+njAe4xdCNMcLN4hF6iyTfQk53Us9YmMFd4u8
	 fwGDa1iWtSufuNtgeZUVQyErKQfyTu4wbVQ5Ef2aRBL7DJKefzr/DcBaNqGkkkRdyT
	 HTIFTqpL4xPSBQB1weBIlmTrXUlV0eFBJ77Vh9MrLJXK5uzorcbLmd0yQeHxgMPBgO
	 mDGfLiTUFsmZKiYlmd6tuVVMGH1r1tAHlHJnxXRxDkucHgHfty/QLV7/7HNpzahZoJ
	 6Yzivmaj9VGdT0Eq+gTWzWemPuh03XwECtQIGFJPhygFSYHoJONvvlpwyI8zcBagBA
	 GUw0SfMEyXdIw==
Message-ID: <sashiko-outbox-163676@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 02/16] KVM: Add file back-pointer to struct kvm
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261008055955.4014342-3-aneesh.kumar@kernel.org>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
 <20261008055955.4014342-3-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 06:16:31 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Steffen Eiden <seiden@linux.ibm.com>
>=20
> Add kvm->file as a no-reference back-pointer to the VM file in struct
> kvm. The pointer is set at VM creation time and cleared under
> WRITE_ONCE() in kvm_vm_release() before the file is freed.
> Callers storing the file must take their own reference.
>=20
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008055955.4014=
342-1-aneesh.kumar@kernel.org?part=3D2

