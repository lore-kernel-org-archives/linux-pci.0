Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7347634C98C;
	Thu,  8 Oct 2026 06:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791440320; cv=none; b=du/bMbWFFKYyv7zZVTybDHaAcUG+7uvpmvANT7Lv77oTKrlMbTXInP1LthSokK6A2PZVSHeBXEPglCqlKbrwm9MuK58KkZMVBZT2tbHkU8C8SF4TFXNoM9bf+7IcdD57XEnycdy5UaAvQIF6SMlDoQnQpNLXFZVysQQuglPGntU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791440320; c=relaxed/simple;
	bh=/XPjLz30YViDF2eRjSS2WxYbdFQgFtW8NT86eUIVNBk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=TXtvo/uu/yucVW2EPeJfDcM85Cu8f5H7tCts3Bcvlwg1D3bzK2iK6w4rq61uavx9g86HswxZzhrqbivrv9yErysVMJMsTaGtUrjWT+XMhJjNySMDbtNutRY/9XOXIVeH58Imse0GR3jLPNpD2c7Kx43s7jeFknSwDxskWAFG2KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbQ+M5LP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbQ+M5LP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2BFE1F000FF;
	Thu,  8 Oct 2026 06:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791440319;
	bh=/XPjLz30YViDF2eRjSS2WxYbdFQgFtW8NT86eUIVNBk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dbQ+M5LPXZYqKEMrgp+sYSlfRbD4BCxEet0jIWhUx5iX/C9U3CHbyeSLkQxQNCHGi
	 8gUBzGG1PIdcvIgHZ9hR7+h1CfB3qK6Lppy71nDo407HGgdo6rc0KtTxTqSoEK/XBb
	 r9HJmUweCChmmMppghRqx8GPn1u6kNmPizlCkARMZWv1LTs0IBabQF0DFTmZ7VsVhG
	 lNcEyAbJd7d5dVCaU2uTcGUoHFUvmzS1FUn+ls0BrC8Y2UhwplNCnvBa+CqdNI+5LS
	 7L3J29Kqch3VjKFmxfVvZNl6Sh3r9Sat7PscRHN6RDmWWk+K5pctkH0Q6ysj1cD2EN
	 4cd17cPx6tceA==
Message-ID: <sashiko-outbox-163678@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 12/16] PCI/TSM: Add vIOMMU-bound contexts for
 vdevices
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261008055955.4014342-13-aneesh.kumar@kernel.org>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
 <20261008055955.4014342-13-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 06:18:38 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> An IOMMUFD vdevice must use the same TEE Security Manager as its vIOMMU.
> Pinning the vIOMMU backend keeps its tsm_dev registered, but does not
> preserve the connection between the PF0 PCI device and that TSM.
>=20
> Add a per-vdevice PCI TSM context. Verify that the PCI device and the
> vIOMMU use the same tsm_dev, and account active contexts on PF0. Reject
> disconnect with -EBUSY until all dependent vdevices release their
> contexts.
>=20
> With vdevice binding handled by the backend, PCI/TSM no longer has
> generic bind state to report. Remove the legacy bind and unbind
> interface. The sysfs "bound" attribute reported the state maintained by
> that interface. Remove the attribute and its ABI documentation as well.
>=20
> Cc: bhelgaas@google.com
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008055955.4014=
342-1-aneesh.kumar@kernel.org?part=3D12

