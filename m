Received: from mail-dl2-f41.google.com (mail-dl2-f41.google.com [74.125.229.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060D34AF173
	for <linux-pci@vger.kernel.org>; Mon,  5 Oct 2026 20:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791231299; cv=pass; b=NWopZHIawMFw3Tbow2PRSRtY4dTTpOUW1CBDAIu/BWZcKq+RDT0cBJ/j06xEjJcR4hbPDSJErX7rNeIz3wHEqLAM3vMMIScEqO3EpTXe/5gNNiwWQ506Ru1wPVTzQUtPl5EZL7p3Ru3r0hAAUmk0G0Y2RjZl01BU6BDMYX6HKFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791231299; c=relaxed/simple;
	bh=Bq1UAZX2PNyexZm1nM9MHPN+8GExNYB/82CSsEV7ikM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Dg4CtO12ZWu5i7EUXNbTAykFHK1BWaT+FKCHws4UhL4GNI2F8YD7guMyn2OYLLH/Kom8CgRlCFGhMiJu3OlgxrtCXUoa/9jBN8c62cpgj9ndW07zS7qT6dT/ptTsIteb0LpneI5fJdpV0E2Bh4QM9txGZ3JNVMrrAyiaXK0uatk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1w6kGNq; arc=pass smtp.client-ip=74.125.229.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1w6kGNq"
Received: by mail-dl2-f41.google.com with SMTP id a92af1059eb24-148bc4a87eeso99747c88.2
        for <linux-pci@vger.kernel.org>; Mon, 05 Oct 2026 13:14:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791231297; cv=none;
        d=google.com; s=arc-20260327;
        b=JYQ6zLWVzRt2Mw/VJHiGaLq8O6MCbYAFUXXohzX5/LPwbqQmwSXJ+M09om2JZyTQig
         ic7yJc1Ec6l6VAeF4la6mBrcPp1LMTbGLp6BoK5Oci7S9STchfNAHbucWV09pFmgFOFq
         lJT+7aS/zml3xyd09bzrO50Get7tJOnzZB5TLscSW6rBI9WZ1ShVFsp6ce96ZRMTfFt0
         WljS09028TxDieRBuoWW2CI3mRwwyeOun+HGObwMuAuVwDjIGbikNDtZmTDwAZwyNYJp
         4l6J961JjtBg5xacxq8Qiqbbbzf2632PR5ShsyuZYYL/ma0e97lW9AjgCT+Fac+FWWEk
         MWLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=AMDrs/XT8ZcB40o2W5+io947QcRQ068ng6Mvjz++tqs=;
        fh=Wu/O42gcMPfDpBk7Z2Ta8XUY4wXw79WeH9ZiXmwGerU=;
        b=TZgQw8F4UFVVAjhi9ieufilFGCWnd9V5cq46Jpv41p4BpeqhF5Ie+TL94yhjRKOBWK
         eMnAY2QvbrQ6Lky01MU9HFjC2WlBAugoA07GhDqNO0Zp1J2AJoviUcIPqZhAWXjvEKiB
         R2KyZZ755bvhKkKfJHl/7nXhoatumirO2d/FKozfHyMD8aJ+0aTH8Jm+Coun8cnKJ21y
         WYJaoywW+G/il+4f2FWIHyQ3CK69bh2DpUEvu6yiQACn3g8bawAEdjRKV9uiD7Sl3ChS
         Z6YqtR4NuovB43ZAaMwTobfLLVlyatCukvYPZnF0McFhZ1v/1YzXg6ZbaVMp0ZRtFOYZ
         m53g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791231297; x=1791836097; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AMDrs/XT8ZcB40o2W5+io947QcRQ068ng6Mvjz++tqs=;
        b=D1w6kGNq1eQdqabGyVRNw4fURXrpNVwRA7Rer/zqQ9BtfXxFeLDHHolk131Nz+m/7l
         0mkF/SBkxiz1qX1hXllL+Ucmq5UhrNCOtbNkwTdKHoJ36f1PahVYtDjLfQj+sk80PhJL
         hh4JVydqt82bznSjn30rfHSk2BtLPHe9MBlfRs94f3FCHiL011ojh54ze6NzZ9VHWtGT
         Ng28rKOqbKHacatnnJ2OjOmMnCC/Uq0rLOq68gjFLIQJ3W6vT4VjG3dA/s9LW6TAnam6
         tUIjoliUM7UMuma+mfoq/NvWs2U7nycNsn3iz159wKbkPs7u/YVQ6MLtKen+2NYrJuI1
         7L/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791231297; x=1791836097;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AMDrs/XT8ZcB40o2W5+io947QcRQ068ng6Mvjz++tqs=;
        b=zauGZBaitulxHMQ4VvrbJivVFTAUeiQZOymbXi8/USj2DdSbZOTTJn0vOAHaCf2nQq
         FjPaPEin5BXBCjbNVogg7Gsmdm1XzN6cUAOVR3fDDprr0yJZYR1hd/OkoCkatdNORV4J
         JT/HdSB81QPUCSpT6maXhz8bGoRQQ8hK/POyIWVHrWYmWqKj697B2QSciMYhu6k8S/X6
         7WkSFRO6GB1JYSNNZ7TarWdBB19yS3u3GEhIWmwmZv6iRknoi/IHm4g9oup12j6UaU4C
         tRyHdi2D6c+zBPROIlQc0SWZGvpu04hxnEe9PH3aSyc+EDhgOlmRXN1GeYRvacq7zait
         zQGQ==
X-Forwarded-Encrypted: i=1; AKwUvByaSbKwtng3wD9wti1PDsYkuonieNr6E72XjwUJhmGxAXMFZNAoO4CcGYa4pE+iOT9+163Gip9rxZY=@vger.kernel.org
X-Gm-Message-State: AFuF++lbl/qc6hvP+BC1BAL4lub4gkwVKzEtfA2crANMjCY/qa4dShkx
	eVB09/r8dzA8n7NsfHhn8Lw6xAV0VqSo2ENowDKkmZaFHrsKhAuw0d8FAmmS4TtFVD7GdY0cOJr
	pHnjzMYTjI1rMm7mcbeoaA8op66QuTag=
X-Gm-Gg: AYBFou0ptI+KpLLQtyC4Os1W6Bcnje0nDzWBh69ObNCHH6mA+cVweL9blcw1wqTbmFC
	L5mo0UvNFa2a92NMRNALBu12SX6cFNQTYaUtSPUneI2xTNbHinmlgje7DnPTO9iOLKTyIVSY1hO
	PYoqNeDCFeGlyWdzvaoSAisv4558mLz4yQHo+eaNQw6gcvv9SEewz5Ock0zN8K2tBr/L+XbWxI2
	UowboR0S3InHbv4SkEialJ84utbjylVKyw7arpp/+78t8HArefmNqb93zHate0YCDN5NpxJg0ZN
	qqhwo+tncIsgN55I4LpywJMIXyLVB9z96MzEcI4JFKxD4eKRULELMIoaSdM4d+5r5yCEDEOpqnu
	MGh5Rsxdkg87GJPK5HcYgnvfYFOXu8fWHCU/1CVZonOgqaMeKgu6H
X-Received: by 2002:a05:701b:424d:20b0:146:ffa9:2117 with SMTP id
 a92af1059eb24-14f5aa4188fmr24322303c88.1.1791231296682; Mon, 05 Oct 2026
 13:14:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 5 Oct 2026 16:14:45 -0400
X-Gm-Features: AclHuK_EZlkeYKVOf5yOf2obDYc8_quHkQ2koc09s-PajMO3v5D25hjL-FV-od4
Message-ID: <CADnq5_MO+ZNOzW+_EH+gUYZ27X_ggWJJ0XdK6m2QW53m_ThtUQ@mail.gmail.com>
Subject: GPU initialization failure with kernel 7.3
To: Linux regressions mailing list <regressions@lists.linux.dev>, Linux PCI <linux-pci@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lukas Wunner <lukas@wunner.de>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, 
	Christian Koenig <christian.koenig@amd.com>, Vitaly Prosyak <vitaly.prosyak@amd.com>, 
	"Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"

Hi Lukas,

The following commit causes GPUs to fail to initialize on a number of
our servers:
eddba19b8b5f ("PCI/AER: Support Advisory Non-Fatal Errors")
The change reverts cleanly and the GPUs initialize fine with it
reverted.  I've filed a kernel bug to track this:
https://bugzilla.kernel.org/show_bug.cgi?id=222095
Happy to test patches, etc.

Thanks,

Alex
