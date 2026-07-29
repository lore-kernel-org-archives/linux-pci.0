Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9862148D887
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 15:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785339339; cv=none; b=dXGMDxBul2h8ZdbbQ673M+eFco3tYPAidLuq+tPPcai+2R9vbztgBFyXd5o8O+ehMQg/Gt1yqoWF9/SRDBdcCgpArqfNOkGwZng8Ybhxp7b9ynuM9b7H5rl3x5iHYJosksLzZAfBjI06skxPb/0sYF4yL28OaEKe0aqyGVsVRmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785339339; c=relaxed/simple;
	bh=GrEJuaMOD4blpgJrZpZ661NaqhwLk5C1vR3qzEnRwBU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nSimH6OTNa7x6NJriKNah6hE+36BAMNxSNV+YJHXp3tmugV0UpBNV58QsrrUHxkVF3leWiOBzYhTFzu9eDXVkrTcqaAe3cTI4bW76fYfWczeo5t3WTLBcXfav/S5J9VHmX1yBV5RfLIywmGF9UZcLdxItol7EgN3vXSksa+hWKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nuTKFAz7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nuTKFAz7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC251F00A3A;
	Wed, 29 Jul 2026 15:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785339338;
	bh=GrEJuaMOD4blpgJrZpZ661NaqhwLk5C1vR3qzEnRwBU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nuTKFAz7iaMBtT5z7fisO5XZ3hoJaKjeNOsfyjnBrQWRDMK9srC2i4pYNhgj4QhoM
	 0H5Q2HR2NiByg2MCoLfKidTqlo5Y1QhQI+x3J2Ci8h984n6t4ndJnR4os3dlKzYKXR
	 1hpgnZzP8/qkHw1dXQnQ5d1kESpnvHptYFJQ39jHRyOAmRGSftbufnJxmeYcpNGA28
	 qUFFlYyQs4b9gLv3XhR3lFBOz9k3Fdw7xnj+R9jH1CvA3KR448nmjwrIOosYY547/h
	 BSxrUXut1XaYeer4k5IOCb57DqtbaTKLgnq98lRBCfv2uTZxEJGRLiLLP8/PVB3mJ8
	 4kuyFbcEg+xog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: vmd: Add VMD Device ID Support for Intel Nova
 Lake (NVL) and Dunlow (DNL)
Reply-To: sashiko-reviews@lists.linux.dev
To: "Szymon Durawa" <szymon.durawa@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260729175320.1400987-1-szymon.durawa@linux.intel.com>
References: <20260729175320.1400987-1-szymon.durawa@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 15:35:37 +0000
Message-Id: <20260729153537.DFC251F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Dan Williams <djbw@kernel.org>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Nirmal Patel <nirmal.patel@linux.intel.com>
> Cc: Jonathan Derrick <jonathan.derrick@linux.dev>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: "Krzysztof Wilczy=C5=84ski" <kwilczynski@kernel.org>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729175320.1400=
987-1-szymon.durawa@linux.intel.com?part=3D1

