Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793152768;
	b=2wVWPlkedu+Mi58Ps2yud/oluE+WE1n+wVqZHh58ZSLWzi1SKZTaD9Os1ZkEVQDQZjUe
	 gB5f7Ea3gtTCcBJTr0GUFI1D3kzwvsUidGu/djGnnHHE3nHa4areQpIS54wcqSwsVpCUf
	 jSf/c4W+9kfKF/yPX7Ud8JeCz14/6mRxau31L5hcBHxKO61XULVj1oUrDJNPgANupu21n
	 O7O93YJR468uSdvh1lLTuJN9M7UGWlX7QZ9zMuS5+qnZnGiADkwGAHuE8ECZUkTu55iiX
	 FbdEBr1cQXzF8jmcxMIU6myaBneNcZbPGMHdaDRqoiUYDwyP478YG6zzn3hZMwsf+lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793152768;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=DHS4IRcRkeGwthYM+/zX9QaAvmyaBpkm4EoH1u9SNX0=;
	b=ZQElg8Tt5KSg7NLBGIDl3QLshap+oEmBbbvMO46x6rT7RPszxawQEbIjhF520LiG5pYa
	 ifV/9fZSsuV2hwJXOBOwnglfoytxZJnfqODY0oSccxMAjFawLJxucrepG+hrB5UhaVoid
	 WIUetOCbz1g2TW3L6PP4sktlpF0PD1fTpq73ZzfiwAjgrSmnUJbVf+cYdbzBzKHHvgWCh
	 FhcNlUuqOQETbWN5sgwKsi/3QA3tAGxjFluMiO6750bJLWc5wR9YQFwdMFj4AcLUhVIvz
	 L8ZnWdxWUwkdkr4fHy2oL+0xTr3n39u3U0AyLEFTsgEGfOfYxXJUfo4cumkMt/WeLfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bXSB0ddo;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EF5606A31A
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 01:59:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1EF5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bXSB0ddo
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so3813395e9.2
        for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 18:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793152766; x=1793757566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DHS4IRcRkeGwthYM+/zX9QaAvmyaBpkm4EoH1u9SNX0=;
        b=bXSB0ddoJhJtjXkwdMkJRS/E2I6TCGhZ04ss0GfAyrdWVyHHX+VR4yLNpJ4QJ5o/e2
         +b0Pea6zANKP+keLpUTqoacpuJ9tTqUPIgVKqSfklDZfI772hui27cWMHH/67fxDRyJ2
         xv+yPcCieDLS0gmPICYj5dugt8Ndh+5EuQSSyUAspl02u1pszzkz8+aE3qk/x91Mcm/r
         xTyRiscsTjYAGhnVIfGSJSvcwIyMhcUuN11ZS+DUOQHjN/kPMdnlydL9df/Jr2jw6bgi
         l215JJHK8cQFTBkTiOT+s12xDCwy8+qc+UMZ7CwJkBvptKgT9HYMalkESpU6Kw2gLeT1
         BLSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793152766; x=1793757566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DHS4IRcRkeGwthYM+/zX9QaAvmyaBpkm4EoH1u9SNX0=;
        b=gFzHJXEJKHX0IIl2bwJ1mzRtx8cQt85zokFblu/aBbmYQ0U1y0AUxBAQ5KO/c+FwPv
         Da7YlvjgDFUK/DOf1DMoPUYGBRIcG4UBOhygnm1HttelT83PwJzpkThry+xztBaIkIC7
         ypyGiqPeU4ZnOuL9EAyuHeMbeiR45zu8PGphH6kD//RjZZPB5VvzzcBrqDXtcgRwLzQ3
         N54E6ffeJxF3kWsYoaOQXk09tXXzGqfV4n5B/XNJB9J5UEEWe7yJxV0syZzfPN5NhX/N
         8bNt5dBrE4W8BllkpVr34WyUr8idpASyCWEmNUnUA9p6jTEGfuZui119pgImoIixegkY
         J9RQ==
X-Forwarded-Encrypted: i=1; AKwUvBx7uEvFMAVjSVpSp5NGFq/rAIb+ySGZkZgX6XdP1aiV0+eOHBIl7DW7ZXt2eW3mcdgJZ1UM9fv8wYQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJlmskFojDwU1wmw66kN+J7b6x+yqPBEtCB4fxGZNDP+BMOKvgO
	DCmymEuENv2ml1kbS7wEVSLrzt6DpS0E4NqEa9YjyF6HnuYvqM5fQnfO
X-Gm-Gg: AYBFou13oRSQ7kcUN/yq49JdwGZ1ODs2nbXpvuFZmikRc70rfgKfmQGXpuhhq1rA4lP
	bH/c9Z7BOhzir4xW/Qil2Xrt35Het+azj4eAIuXl1W3hFq8H5VqoURv42InYWFb2f2MIEF/6qty
	VmpQKrFrKmyGi3TlGoUezhfWkEada1QvL54ZGFBcOVmJIboPe9ZyFAIpd1p6+vLVMq5ur1ULhZ5
	VheJ+/Yr3hOfWYf6COtk465o2iBPfWGYhv7sthTeQ3ZkDFF1sHf0EmOlHJ+XSx6Oul5JPkpxSbP
	mJxTumSRHY/N8E3S/gxxY9IWkuaU0W/EOUJY4T+XieiWT+rtHV2TcXzOHGSRwt8C83pMfaXVXl1
	USnTRrvKVy0Glu5lapOt//rRB4sm35H8DRxGnFBllUmBvNZfErpOtrsr84j2Pgtf48lJBJu2+LN
	Kle2VUFGdJbhwRjjaY382ilfWjkv7Z9pMYn82mvwoQMQtcIQwE5t1p5GspYgVl5qDllym2FW7ps
	aItHht4JQFB2ijVcqFKk2x+7M8jt4IkhkCgf8o41qFThviLOazWkmZhlbIinyzGBRcoxnbquniY
	R4m9cnP+DrHXpWtz3rkgNayMiyUpnQ05MQdLGbj50Vhm97ANA9bBzo+NkKBHt0WK4qBkcokcWzR
	SEY7WokfYUlI3ug23XfpENaSSUsXA60hDeuyyAk5jmssZo3cTTxFdit2iQTb+fkauuF4=
X-Received: by 2002:a05:600c:19c8:b0:4a1:df52:3e36 with SMTP id 5b1f17b1804b1-4a967201e9dmr16334615e9.27.1793152766074;
        Tue, 27 Oct 2026 18:59:26 -0700 (PDT)
Received: from tachyon.internal (2.155.41.158.dyn.user.ono.com. [2.155.41.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a976010ca7sm10831475e9.1.2026.10.27.18.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 18:59:25 -0700 (PDT)
From: =?UTF-8?q?Enrique=20Hern=C3=A1ndez=20Bello?= <ehbello@gmail.com>
To: shawn.lin@rock-chips.com
Cc: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	manivannan.sadhasivam@oss.qualcomm.com,
	bhelgaas@google.com,
	robh@kernel.org,
	heiko@sntech.de,
	dlemoal@kernel.org,
	linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	iav@iav.lv
Subject: Re: [PATCH v3] PCI: rockchip: Don't lengthen PERST# when power is already valid
Date: Wed, 28 Oct 2026 01:59:23 +0000
Message-ID: <20261028015923.2436122-1-ehbello@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cf541723-eb4c-4ba6-92c5-33baafc20e7c@rock-chips.com>
References: <20261028005603.2399220-1-ehbello@gmail.com> <cf541723-eb4c-4ba6-92c5-33baafc20e7c@rock-chips.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 28 Oct 2026 09:34:04 +0800, Shawn Lin wrote:

First, an apology for the noise: a v4 went out seven minutes after your mail
and crossed it. It answers an unrelated review comment about T_PERST-CLK and
does nothing about the points you raise, so please do not spend time on it:

  https://lore.kernel.org/all/20261028014116.2432425-1-ehbello@gmail.com/

I was respinning too quickly. The next version will wait for this thread to
settle rather than landing on top of it.

> The assumptions here rely on a very weak constraint. If some designs
> don't define the 12V and 3.3V regulators in the device tree, but those
> rails actually do power down along with the rest of the system during
> suspend, then upon resume the reset wait will be skipped entirely. I'm
> worried this could cause regressions.

You are right, and it is worse than that. vpcie1v8 and vpcie0v9 come from
devm_regulator_get(), not the _optional() variant, so when they are absent
from DT the core substitutes a dummy rather than failing, and
_regulator_is_enabled() returns 1 for a dummy:

	/* If we don't know then assume that the regulator is always on */
	if (!rdev->desc->ops->is_enabled)
		return 1;

Combined with my IS_ERR() checks treating an absent optional supply as
satisfied, rockchip_pcie_supplies_enabled() is unconditionally true on a
board that describes none of the four rails. The wait would then be skipped
on every such board, on resume included. That is a regression and the patch
should not go in as it stands.

The underlying mistake is that regulator_is_enabled() reports the present
state, not for how long it has held. Probe can bridge that gap: the system
has been running for seconds by then and this driver has not touched the
rails yet, so a rail that reads enabled has been enabled since boot -- and
that holds for a dummy too, since a dummy means nobody is switching it.
Resume cannot bridge it at all: the rail may have dropped and come back
microseconds ago, possibly below the regulator core's visibility.

So the next version drops the resume hunk and sets supplies_pre_enabled to
false there explicitly, leaving the full wait in place on resume. The change
then only touches probe, where the inference is sound. That also removes the
one hunk I had no measurement for: it came out of an automated review of v1,
not from hardware.

> Intuitively, one would expect that a short reset period prevents the
> endpoint from recovering fully, that seems more plausible than the
> opposite. [...] Therefore, the actual observation that a longer reset
> causes failure is highly counterintuitive.

Agreed, it is counterintuitive, and I cannot explain the endpoint's
internals -- only what it does. What I can rule out is the reading your "as
long as the reset is clean" suggests, that something else happening during
the wait is the real cause. Link training is enabled just before the sleep,
so the root port spends those 100 ms training against a device held in
reset, which looked like the obvious suspect. Moving the wait to before the
link-training enable, keeping the pulse just as long, still failed 0 of 15
boots. It is the duration, not what the controller does during it.

The v3 table is one kernel with two module parameters, one sleeping before
the PERST# assertion and one in place of the msleep, and the host driver
rebound to re-run probe, so nothing varies between rows except where the
delay sits. A rebind reproduces the cold-boot failure identically, which I
checked before trusting it.

> Furthermore, even with the same power supply design, different endpoints
> may behave differently. What if a particular device requires a longer
> reset pulse to work reliably? How would we handle that?

The only floor the spec gives is T_PERST, 100 us of active PERST#, and v4
started guaranteeing that explicitly with an fsleep() rather than relying on
the 100 ms. Beyond that there is no required minimum to preserve.

And the short pulse is not new behaviour: from the driver's introduction
until c47f90be4c89 in v6.11-rc1 there was no wait before the de-assert at
all, so the pulse was only as long as the register writes in between took.
That is what every endpoint on this driver saw for years. The 100 ms pulse
is the recent change, and it is what broke this one. If some device turns
out to need longer, that seems like a quirk for that device rather than a
reason to keep a default that regressed another.

Thanks for the review -- the regulator point in particular is one I would
not have found.
