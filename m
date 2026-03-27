Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D479A3EC2E7
	for <linux-pci@vger.kernel.org>; Fri, 27 Mar 2026 17:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774633718; cv=none; b=HGHck7bkc67IZHK7xSr66TqmALxfZ9826SlmsfMuyDJWqt5jbnJHucUsBLPuaoe6IRofMwE9+gHbuX2X+8LlyOp3eYQiyckw3p/mKQ/iYfmvwaAlJxycnwJjXNANrx0Gj/WnQc4g2lVzYTcw+VfBslvIVvwqKcQuqVvoE3nussY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774633718; c=relaxed/simple;
	bh=llklB1En8Ndzue06w7liksuXHSZughmp9gHG6cT0T9A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:Content-Type:
	 MIME-Version; b=uZu+HQ6UGGIuBtDqQ8dEVKnXdHgb/kNXT/DqKJ+Jeo/9aKWnzOcRgTibg6GHFAX1ZNLSBxCegBxkIWPlAvB+rPNroThpVfBQ4ldI9D3UYiuQMmzU/NVXCnwibJaee0egi7RRCVyWakB9pPTwyMxnQRd0S19urwyYAGsMxli1bRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZP2xBRlM; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZP2xBRlM"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a283c44478so2632148e87.3
        for <linux-pci@vger.kernel.org>; Fri, 27 Mar 2026 10:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774633715; x=1775238515; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=llklB1En8Ndzue06w7liksuXHSZughmp9gHG6cT0T9A=;
        b=ZP2xBRlMHJGZZ7sEvUDuqeo0o6arH3oSL97+mRv1w5NYLE8p2phprtlX4RtmJD2TfT
         rCkBMoYqQloyOKa94qmu20VmPFn9j2PO3n9UFgHnfsPd64Tuk87zszMBfj96VsRqbgqD
         +R8E+GNa/I/Vpj6VCUFkTonYYBvKVeR4Q5c0Et6LHs6TBSDwISkzx7GqsWl+LirP75Hg
         9Rb/MAJx3f216jcpfq9UaLIWCcW1QRClo7/FB3i+heCApYHcBeX34xgBr5g6t8tZBR5H
         kcB57POP1AXVVE+ivRh/iqLus01EMekZOh8YHIdWuMBES57xya0JCCh2riqTCQq/uEhK
         bWUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774633715; x=1775238515;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=llklB1En8Ndzue06w7liksuXHSZughmp9gHG6cT0T9A=;
        b=W99ImJe+iVZ7b6cFZ+FlIB1IeHg+AzFM5Nn+nm80rMvv+X9QM7k/YsoSIXfcNUqtch
         eOaa1j2Jmig6PxqkI1spQs+o9Ai0iqoVQMxHBuDOntTj1CZJ7cl9YAXiVJ2wKyzCQ0O+
         ExWoVZhrl1oPgC2wZN37leSN/V+AvnBtCTlPnlA7M58jszHbbv4dKtOUHyaLdZQFABNA
         VlobkIHjoPW4caJS2sZmr0lDBQvdIbjt2ULnu5xeOy79UoYaXtM8D5eOcxpomlzez7A8
         m5WMVdUSOM2kyraTWQ2xlfiKhnjpUHpNOtDyPZJVnQjGM+Vt0Xk2QCmNsjEwexNt7JlZ
         F8hQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzP/Sq6goqhYqrMFzgYocAiJsgqN+VQG8hls95TVkSQs060T4HrVdu4E1q7b9i39g6wcwx7Io5+YU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2NggnqCWAkJVMnkpLULVDPZtMubcpTKTdk+F8JgGEYpTQmEuc
	Na+dZn2lM2sUdUXkLiDvZn4Gcn9NbZuWRPl3W8dxqtZo0bWIWZqbmH0=
X-Gm-Gg: ATEYQzy5+EAybB9u3HOQScF4G3YVS/tsh0NhjPnmDY0ILOJ6tdpla9SfQMv8lJVrXOD
	0+C8+lrArq8041jvGFkk9sdv0DEjectwr7FA7u+h+x/KXKSzQ2P3YNKu0Zafj+FK2Opk+jT1TkI
	1cIMBxfq2XsWOunyFfKb/6rz3azP1Nyaqunw03uiMT5Iz9IdceUieX2OofbuCyhJm0u7KccgIU/
	uNzy06yXBpBuCt6vbd4SydvtaRyOn8xv+btDMch05teyDaHD4BHDB1vFyMfEtzgt/eq2TqS7cQE
	6E99kSr0lNHRpFobuNnslolGk9PlgtvSVMrqriqAHtmXB5GMx5NHvgf3UGjWzbofBAUpUTmMrZF
	U/Xj3LrvcGdF/JyqiHaH2bSZ9FVQqZdqIbF2ESPDJIq8JVwngizBtHcseTWZRCPiSwQXQcLzC2G
	fX9kvejrEqAj7B0E41eDfQry5KKAlvkSB8AvZbl/d0pvG59XEUdLWdVxpBs/k87WH0ol/lX3xbU
	eOAQXdo0fwxxT6Q7Fiy+E+HjkUdUhJdiepZsWBG3tMg
X-Received: by 2002:a05:6512:1088:b0:5a2:a13e:9095 with SMTP id 2adb3069b0e04-5a2ab5ff25emr1603294e87.9.1774633714730;
        Fri, 27 Mar 2026 10:48:34 -0700 (PDT)
Received: from bf-laptop.int.bjornfor.name ([84.215.3.106])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2a0645116sm1498878e87.21.2026.03.27.10.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 10:48:33 -0700 (PDT)
Message-ID: <c4c952a0adbb28e572f2a05fcb317f905fe3f607.camel@gmail.com>
Subject: Re: [REGRESSION] PCI: Revert "Enable ACS after configuring IOMMU
 for OF platforms"
From: bjorn.forsman@gmail.com
To: mani@kernel.org
Cc: bhelgaas@google.com, iommu@lists.linux.dev, john@kernel.doghat.io, 
	joro@8bytes.org, linux-pci@vger.kernel.org, 
	manivannan.sadhasivam@oss.qualcomm.com, robin.murphy@arm.com, 
	stable@vger.kernel.org, sashal@kernel.org
Date: Fri, 27 Mar 2026 18:48:32 +0100
In-Reply-To: <ovfco6pqzw734flu7navat36avt6yfosruouduhmbti7umunus@ijmu6nhz56l5>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Mani,

[CC Sasha Levin as git committer of all the cherry-picks to the LTS
kernels.]

What's the status of the reverts/fixes?

I tested even older LTS kernels (5.15.x and 5.10.x) and they're
affected too. IOW, the only LTS kernel that isn't affected is 6.18.x.

I hope this can be fixed soon.

Best regards,
Bj=C3=B8rn Forsman
