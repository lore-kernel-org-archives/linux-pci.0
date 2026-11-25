Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795589166;
	b=v4PcW41Kk2CjLbEYWOS3R6oqxkP8G396PLXiqcGfnvd/8rXbUtmXFFtWSlGITXAbPTjo
	 mdgXH/pMIV+Sg3rSfLppN6N3v3XTQ8ymDB3PqLVoojzneslrYURxqROm0q/fq0vkE6kcU
	 hGqTy1Z8YMg4O+D0lKoytIJpvl2MDIlWTihSxSdymGuT4OhcnEmAM9LG7pkTBp9ksT0e8
	 LU5GSk99fVGTtbjHs6Srclix9DcJgStA1HhdlEip1DBiU6TFeLg48ewt2eL478JtM/zwk
	 iUJWNMjQaClPyHjShiNHnk45vSwyn2wkZxrSrg0M7e15KSsRaEJwsse5MixUdYlWSwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795589166;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PYbbLjNa+nAgv+Ii4Fjqk6MWrwGTRDvZlTwnrhZ1zJM=;
	b=J0dvUdiuTGJN2oSaVQ2UdKYY9o19LVA5fh+GmlqIPCc2xFZqalIz062KvvgiNCrfN+mQ
	 8cM2my97bB6mM/dJSsPQuPVpkCo9zPFK0FfYllM+YIO8hurDosh1fPStZh1jUcmEQMxso
	 YeOoMMiUABxg5wXT2apIAeyy7Wt/XXNo87W/yspKBFy0rs+wAvB3VjNd5ym9CKLxMbrWv
	 QoLB8nHqeEL/p7jQvMyQeGCFzLhbf1As8nnIxUKuv46FmTR+ez/K4vFpgX53zuBPfG7Co
	 uR1GfX5AUuiw4JZ8aK91rSsZhd3KqGNyGqcNdJawV2pjw3e93XYTpbct3+kHsW+fwlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F67wpeus;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9FB606A321
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 06:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F67wpeus
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F40251F000C6;
	Wed, 25 Nov 2026 06:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795589166;
	bh=PYbbLjNa+nAgv+Ii4Fjqk6MWrwGTRDvZlTwnrhZ1zJM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F67wpeusNfoDPLWD7Zb07jELFMQrRuOVMSa7Ade2jpaSFXnRvCv+Gm1R751fUnJHh
	 l8T7P1N9gC/+bnX0OqMz6z3npBSJ8m46iPaXZ8A62QyJX6guWplA/qTGM9NO+HHldT
	 qsgFbI+CBP3tukGAPeAYTToBpgdr8/8GRm9MusV2UpLcNdTVWsOHGY6SZEr/MbGijx
	 MeRm+rptlXLPebfEd4IQxgOs7mFY57zSQoCJTmvq8olc//fLwL3vk5oRE7oV0Toyou
	 u/kB652fKWBos+zpxugNEns0Wrmvar7Z3S8FVEaMYURXMZqcznn0m6xukOMe66oByd
	 ul4WwTUNWnEiQ==
Message-ID: <sashiko-outbox-232733@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 0/3] PCI: Add Lane Margining at the Receiver debugfs
 interface
Reply-To: sashiko-reviews@lists.linux.dev
To: "Priyank Rathod" <rathodpriyank@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261125-pcie-link-endpoints-v8-0-19d49c17c05f@google.com>
References: <20261125-pcie-link-endpoints-v8-0-19d49c17c05f@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 06:46:04 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 3-patch series:

- Patches 1 and 3: no issues found.
- Patch 2 ("PCI/LMR: Add Lane Margining at the Receiver debugfs..."): 1
  potential issue (1 Medium)

A detailed review has been sent as a separate reply to patch 2.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125-pcie-link-=
endpoints-v8-0-19d49c17c05f@google.com
