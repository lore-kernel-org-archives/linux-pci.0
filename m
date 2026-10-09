Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABB13AD522
	for <linux-pci@vger.kernel.org>; Fri,  9 Oct 2026 12:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791548077; cv=none; b=qZGbwHA2uj8IqG4TarbLMOZTYKj/t7+VC+JvBDoGwIl8emy+sl57dez87wUvzPS2Jf2iVISw04CC//YsaEC2NSWSyoUATOzQizFHN3LaFBb/uAAKP3YgdCU7dHhEuHWnTto3WPpq83p4GkMxyKZi+dNiKJFUa3QH3KPZsi8KmnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791548077; c=relaxed/simple;
	bh=0wp4vMpTTbKxmOcrBbd4LZZUzPZPjqMgHGJhHKYOOwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BhM+47QvMjqVGsV57+fv2FMOgrnq2AkP9zEGAzAbmGSI/2mOnBPuxqakA2ksnr4wEpn4CeQZ5JcSOdONGPQpGS9SBn9dEJgffMWW3/dn0hBPCOsyazMXqK/2grsYN9ia4KtvQMquzFgA//TBQyin9K5Ug9Ypv+gKnmiRliTCYCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z9nmZpe4; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9nmZpe4"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-351767ef18cso3149140eec.1
        for <linux-pci@vger.kernel.org>; Fri, 09 Oct 2026 05:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791548067; x=1792152867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a1/r00KwLC71l7qD8SlMXbKms6f/x3lGEnJZwDjSrz8=;
        b=Z9nmZpe4CrdMXiwTD8nj+ROgWtOqY0nySjUqKYHV10R6zGopaxoyIgPED7KYucoePl
         xaM6O8nyG2MsLaFaeXXX7HQICqDHsx1XzlavOp51nPPMwP1JQCr355/nYaaC70heC9FC
         vNm2jpr3KJl55hrZCmL8YDkz4MhiMhYaPA2aw2E7nFqWVIUg290H3XyGFlvjcxVdhn5Y
         eQAnuNyVNMkmsRksYbjr97vIQCPg5WSRzO9XBYdGyIGd+lHZ7uA0/SSKZ75q4aFGgc8r
         nsfv/lm4kuE8MF7WjhdikAk6AU3U0RN+hOGQmAzPhDYWd/PZtQn0E9t7i4Qw55ms5bDP
         urQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791548067; x=1792152867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a1/r00KwLC71l7qD8SlMXbKms6f/x3lGEnJZwDjSrz8=;
        b=xmXT66476ia/cDtu4NVUs8/fadhJCjl/GxGL8EKBj0nPcgYDM2qFwd92pgEmwRNsnV
         fKFLA7X0b4qMIpZ13auQKTyCBPE/zFLbLr+dWlpFrmcGHEH0gX4mGm3u5iyx/fklODlJ
         2v/HoRlwQXju/hBxn6b9fOX9KomeQkJfB9T3bn9TxRTzVPMyjn+wEq8LZBzBcn1Gw9RP
         lJtYk85oElxj3zCJnTT3adHVNaaLYZWwMWQXTGvToVtHTrjGnzjzBazed4OM6zLFvOH8
         wgW0AUhFR0xX+7YkjssT198xmSzn0Bdsf1mfwyQ7ZkuB1dcQVFLsfJsKiVUShVvIu9Ww
         7IUA==
X-Forwarded-Encrypted: i=1; AKwUvBxYd5WDeDQNL+HNulwin0A3Cld/b1NlORtCGisZ4N4XiG23Jnkv+gRtjvvh2dUNsQ4Hj928RhyIsVE=@vger.kernel.org
X-Gm-Message-State: AFuF++kdhXJccsywfPxp+ZxBsi+NhDSnKJuDaphmDFfVSuJ7DRSZxNpW
	oFQtJvzYuwhc7GqojdEJUzPtQRKgb8p/bp3AnOWWz3fgdZcfBqdQ+a6YLZV9z8iJ
X-Gm-Gg: AYBFou0UWhqfCd9BtQEsSK29qA20E8zSjBdE/R1yoIpgag1/AsVTGxT9u2Qe4z06rex
	gheGATtyj7dDecRZZvc+G3Qal8hK3lloO4jSRB5gHd8O/qD3fLgJ0cwVWckNCAF3iBAQ9KksyhG
	FFm1sWO0FZDnnGtThIFJJXCXpyC+ecaFUUi8itFX5ueSBFJ58mkMy4hrCqUmyhiUxrb5WHaH1jI
	JaUqPR3SV7HW3+HADM2t0zlatcX96uVynrgk5q4vvG+l9awxyQs6owX3z9oMrbeoeXiFlPAuv+O
	5jSxkpWgjJmkNbfnKkFCpI6jNwUFlWt/Bw91WnVjI++koy6BiXbVj7lk/FQbSgdUs5qamGUkoaN
	C+zFAUCX0aZul7mvHz9jkfX+OlLbAh9F/y/qAxf7g+P0C5Q7wuJF/4xB1H+Iw/iAxkh4s69/0Vt
	TPcUMPOjFy0okyQZLe8Uy/Qk1noSRbrgtE/EJO9aUWWlUO8ds7KW7s75EiufWM7R90AtPLqdfyi
	5GjcSkf
X-Received: by 2002:a05:7301:4b09:b0:351:2958:1740 with SMTP id 5a478bee46e88-3537e088bf1mr2376765eec.37.1791548066814;
        Fri, 09 Oct 2026 05:14:26 -0700 (PDT)
Received: from maclinux ([2803:c600:9110:8ba5:1c75:eeaa:b22f:20dc])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca1ba7esm6895458eec.7.2026.10.09.05.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 05:14:26 -0700 (PDT)
From: =?UTF-8?q?Francisco=20Beltr=C3=A1n=20Millal=C3=A9n?= <fbeltranmillalen@gmail.com>
To: mjg59@srcf.ucam.org
Cc: helgaas@kernel.org,
	rafael@kernel.org,
	bhelgaas@google.com,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lenb@kernel.org,
	linux-kernel@vger.kernel.org,
	d@rrell.co,
	andreas.noever@gmail.com,
	westeri@kernel.org,
	YehezkelShB@gmail.com,
	lukas@wunner.de,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH] ACPI: PCI: take native PME control on Apple machines
Date: Fri,  9 Oct 2026 09:14:13 -0300
Message-ID: <20261009121413.23538-1-fbeltranmillalen@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <asikbIuZUZsgmU52@srcf.ucam.org>
References: <asikbIuZUZsgmU52@srcf.ucam.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matthew,

Thanks for going back that far, and for the explanation.

On Fri, Oct 09, 2026 at 01:23:08AM -0700, Matthew Garrett wrote:
> I /think/ this was the set of parameters that my machine would hand over
> via _OSC if we hadn't called _OSI("Darwin") - but it was over a decade
> ago so I can't promise that's the case. I think this probably needs to
> be tested on some older machines as well just to ensure there's no weird
> breakage as a result, but if PME is actually hooked up and there's no
> SMM managing it instead I think that's fine.

On the MacBookPro14,3 both conditions seem to hold.  With the patch, the
root port takes the PME interrupt as soon as a device is plugged in, and
the controller is resumed in the same second.  Without it, nothing picks
the event up: the controller stays suspended for over a minute with
PME_Status set, the GPE the firmware declares for those two xHCI
controllers never fires, and its handler doesn't notify them anyway.  I
can't look at SMM directly, but if the firmware were handling the event
itself, the controller would have been woken without the patch, and it
never was.  Darrell saw the same fix on his MacBookPro14,3.

You're right that older Macs should be tested, and I don't have any: the
patch has only run on my machine and Darrell's, both MacBookPro14,3.
Two things make me think the risk is small.  Handling PME natively
doesn't turn off the firmware's own wake path, so if an older Mac does
use a GPE for this, that keeps working.  The only side effect I would
expect is the PME driver logging "Spurious native interrupt".  And on
these machines the kernel already takes over hotplug and AER without
asking the firmware, so PME would be treated the same way as the rest.
If anyone on Cc has an older Mac and can try it, I'd be glad to hear how
it goes.

Thanks again,
Francisco
