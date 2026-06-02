Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A169137475E;
	Tue,  2 Jun 2026 18:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780424568; cv=none; b=RSKZ6iLneBQS0D3H2QTT5DQu3Ye/pJkV0t40p+pYSVvsxTo08/iQxG/iGkmbXZoHpKEqSXxRyxb5Eyu8ourxD1PQRstGpUFXEegDZl7eQn4+Lsg2KoXsl89o/vETXgxZYhRngp71gVC3DY/OAtqouRiCvqHCVSa8XLbu07Pnc14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780424568; c=relaxed/simple;
	bh=q/zRnmgTcuMqU6GFs28oPn7OQo/fsYcSZD49UdBdWso=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CrXiT/lv4Ma4qFB83k2ERQI/O2LUOn+EvOReFOo9DaqWWc4X4VzOhlH0mLIdgqyQhtJEyl2+SrTdH2cWjZM5FZAqQ6DSu0EG503djj65+jUgLEyY3os79CaXR9vTWfhBGvIK7qZmnCRIaO48rlXx2I2Hm+9Z0Dgj6JBL9lPBTtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=Wlf5QN39; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VTL3trM4; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="Wlf5QN39";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VTL3trM4"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 457031D00071;
	Tue,  2 Jun 2026 14:22:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 02 Jun 2026 14:22:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1780424564;
	 x=1780510964; bh=xgNU3TrctTAJMmDCcQz8DP5d0O/rTFeAaeGmhvW30U8=; b=
	Wlf5QN39TDe+/x1WqDPCTCx1UbCQtLfmc42mCn6ccVPH+/rShc688+es4liuqGWU
	vtUIspuKyKhbgfiOJQRpr2vDe7KaaKkeQrNAKliTkApY6mvpHC47U6bzltLjgopP
	WDRqMUPbHRtRUKLyvxQm2Tn1W3RA+n3KAXkvD2AwM7qzlbKf2RLRWI2UfJxRMVRw
	Dxr8mzoizzfg0AzmaLG9JtGOAX45Jkmsb/U+f6369pDE53bXBby5K4Qg/7o932WP
	Al+W/sj9bLzPnosl7vJVjelBKnwkBjQt01PnrnT4h0YVWgWQ0l69Kqjx7PSc8+2x
	oJ8YbkZfbmoj+E6KhSD08A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780424564; x=
	1780510964; bh=xgNU3TrctTAJMmDCcQz8DP5d0O/rTFeAaeGmhvW30U8=; b=V
	TL3trM4MSQE5JAMNMQPQEm+fwPTmHaB+HbUImFDZvEk6wo8cHd+wSJeqdhSyIaw+
	ehkZep+3UID12Jkpjt24IzsPC3o4xj4CfkMgc19elV9c2b102+PC5HrlYJVh7zDg
	cZdoYJqVNAZtEO6vv0gj383IyHqzSzqDN5QYuV/5JWL1v5y3etR0yS5ZDQDb6cz4
	6jcNSPbCllc/NjNtsjBZZ50W0Rwhcj70NSYqUdMghTyzwEbjK2QLaqx8GXRBxzRy
	DpYzHDwALMJDk5Fb1Pnx384xGP9s2b81naoF5BU5OjWhRLEflBp2C4wbSgDcb5gB
	p0mnNwmTcZJ1zPrcaaBng==
X-ME-Sender: <xms:cx8faoV6SHdg6CEcgCnVp8PwHn9uha8PLSKsnFjSQaRyY7SSYBSrzg>
    <xme:cx8faod7cCd7KY6NQBmiBxTdpqjLGLTevgJ56_esPb9x1xln_1tKJxQv9VocRQveL
    tz4tK31H3Ahe2cDPhXBlMwhhEkvzmvp9egQgticYxFchN3T2ux8ig>
X-ME-Received: <xmr:cx8fapb9HpzY83ZSK0eXdAEaR2EEUVIpIZ7hYI2RuR6Nht-o77qscbazHT8>
X-ME-Proxy-Cause: dmFkZTE1TtLXImJsmYp6Zo6UPLyHtYqltcI+aFi74EmJDJ95X0U9vFh5s/JowNANbX/Mbb
    HGy6AHdBMkvqy261LXJAnJ/v/Z9t1cveBHgFkrJJZOx1QjDUQ9Waoq96o5x4tWLv3DY6St
    8Exzu2yNjZPUzpS22DCVRZa09p6gv5xT9HIwdntyCnHjXxrbv5XDeKBhzQRje+YbLs2rbJ
    Zem9ipsJ51DrvJKRQuiF0OyZlgIT79ADYUGFWPSaWHcPFPzXMSFrLHRLGyyY5x3FlpoZiO
    pfgwtT6T8IfAM0ZKp9VnNsJtLSggl24ZEvhswFhq5cNrP7Kb9GlLz34kyYfurk0V0F0xn8
    GOn2ijQ7bsxV7MWTCKJte2bRa3XXmapV/der0mW6JJSBIwk+0WRkMZz2bxzigcO+T2qsyZ
    uNuJFuIyIX7SosgCuW0eguJr21sSaoPPMRuOm8ELB5P10RQTQ3qwEmJYWOD3ykGlWkP7sp
    7qfLZRm1qowaGBSMnVDqSbEfxHO/yL1CD+jyoCHPnqj6KVBBPMjCtFvrXbxZrPQ5XqnOAm
    KzGz7AColH6hq9YJ2iB4uwiUvG8yP/zwVy3BSyQklB+dJpeZ4W+eSu0yCxyJIKmGReiJwF
    iG3bwJYvot9PiGEtbKgMekejvq1DPm6o/88OYKJgf4SX40wxRx3J3iE/ut1g
X-ME-Proxy: <xmx:cx8fasMngOgs8NoKrLzpTK6iW7GasRXNcxeM9uo2pQ38tilL9rnAUA>
    <xmx:cx8fanVZX6wINjOE9ZvVMJsEP6dV2gYbl1ylvcATtNfcmG34ifp1cA>
    <xmx:cx8fahJygi9bMTJswmkNhXpZUcE9me6XiwiVL6X2EM9QZ4L8Jnvecg>
    <xmx:cx8faipUKXhOQSfGJq-S5VCj6k0BbdzybHoyd5p_Q6mLGKhgGBfWNg>
    <xmx:dB8fanXKCKjzinkqWIdW8hchKFkQrI8wjZXypvkNt_9aSk7aiTGheIGB>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 14:22:42 -0400 (EDT)
Date: Tue, 2 Jun 2026 12:22:40 -0600
From: Alex Williamson <alex@shazbot.org>
To: Ankit Agrawal <ankita@nvidia.com>, <bhelgaas@google.com>
Cc: <kvm@vger.kernel.org>, <jgg@ziepe.ca>, <yishaih@nvidia.com>,
 <skolothumtho@nvidia.com>, <kevin.tian@intel.com>, <clg@redhat.com>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 alex@shazbot.org
Subject: Re: [PATCH v8 1/1] vfio/nvgrace-gpu: Add Blackwell-Next GPU
 readiness check via CXL DVSEC
Message-ID: <20260602122240.0c193f2f@shazbot.org>
In-Reply-To: <20260602063015.3915-1-ankita@nvidia.com>
References: <20260602063015.3915-1-ankita@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


Thanks, Ankit, this looks ready to me.

Bjorn, there's a tiny pci_regs addition below, I'll assume it's ok
unless you say otherwise.  Thanks,

Alex

On Tue, 2 Jun 2026 06:30:15 +0000
Ankit Agrawal <ankita@nvidia.com> wrote:

> Add a CXL DVSEC-based readiness check for Blackwell-Next GPUs alongside
> the existing legacy BAR0 polling path. The CXL Device DVSEC offset is
> discovered at probe time. Probe, fault and read/write paths then branch
> on that to use either the legacy BAR0 polling or the CXL DVSEC polling.
>=20
> The CXL path polls Memory_Active, requiring MEM_INFO_VALID within 1s and
> MEM_ACTIVE within Memory_Active_Timeout (up to 256s) as per CXL spec r4.0
> sec 8.1.3.8.2. Given the long worst-case wait, the CXL poll runs outside
> memory_lock with only a quick readiness check is done under the lock.
>=20
> The poll loops sleep with schedule_timeout_killable() and return -EINTR
> on a fatal signal. This avoids hung-task panics during the long
> uninterruptible wait. Extend this to the legacy based wait as well for
> improvement.
>=20
> In the fault handler the wait runs locklessly before memory_lock. If a
> reset races in, the in-lock recheck returns -EAGAIN and the wait is
> retried rather than returning a spurious VM_FAULT_SIGBUS.
>=20
> Add PCI_DVSEC_CXL_MEM_ACTIVE_TIMEOUT to pci_regs.h for the timeout field.
>=20
> Cc: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Suggested-by: Alex Williamson <alex@shazbot.org>
> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
> ---
>  drivers/vfio/pci/nvgrace-gpu/main.c | 162 +++++++++++++++++++++++++---
>  include/uapi/linux/pci_regs.h       |   1 +
>  2 files changed, 151 insertions(+), 12 deletions(-)
...
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 14f634ab9350..718fb630f5bb 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1357,6 +1357,7 @@
>  #define  PCI_DVSEC_CXL_RANGE_SIZE_LOW(i)		(0x1C + (i * 0x10))
>  #define   PCI_DVSEC_CXL_MEM_INFO_VALID			_BITUL(0)
>  #define   PCI_DVSEC_CXL_MEM_ACTIVE			_BITUL(1)
> +#define   PCI_DVSEC_CXL_MEM_ACTIVE_TIMEOUT		__GENMASK(15, 13)
>  #define   PCI_DVSEC_CXL_MEM_SIZE_LOW			__GENMASK(31, 28)
>  #define  PCI_DVSEC_CXL_RANGE_BASE_HIGH(i)		(0x20 + (i * 0x10))
>  #define  PCI_DVSEC_CXL_RANGE_BASE_LOW(i)		(0x24 + (i * 0x10))

