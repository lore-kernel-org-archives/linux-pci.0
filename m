Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F363AE185
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 03:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788146683; cv=none; b=GHPQiWMdJvMXHxd5y90XYnWU9yWYptOcNZT/xHMLr+mxDa0vp87R7jbyRVNlTVZUO6a19cT2u71nCZPnsVWPDBVhxQIn++a+qxUbQ8tl3HXBNKhpfKEujRdpzBXtpcLWk7586V+80il2qThOgETAZ3vctiRn36rIaJtEpAx4sW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788146683; c=relaxed/simple;
	bh=+jYrMNj4gYVMpOQjdgm3R6wNO/eAnlIxPedhB6P4YHU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B4nLKYNBYsd2S6AKD6YClrTpPxFrtK8xADs6rA7qbHupCYkc0pGg5q7yKnRGPxGjXiE4ce5NLia4wFhn98MKh85cVPgwfbW/wOCchYs9XbGvUepjkjf2KurqR7/Lr/Gj7p98EkwcQlpnVkgILWW55AixeKW7J7QTY1sWhAPyqKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eX+7MwOC; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eX+7MwOC"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-396901263b6so4724134a91.2
        for <linux-pci@vger.kernel.org>; Sun, 30 Aug 2026 20:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788146681; x=1788751481; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LqUXShy4Y1uwDBlZFsBdfY3ls/HGLA3gGP5AeZZ/dKE=;
        b=eX+7MwOChS4Fnsiwvda0cscMBNlOieLpIwoNf/lRnLvsYdqgCHDyepNM6TE9FjrU/h
         WvXNuA90ZSFAAe8D9QEPfMKOtg+t9/OZ53nDzlnCPp/9KO7dwOPYsS5SigHU7U8vVg5X
         WSaK0ds7yWk9I46AFQgnkVFAa+IO12XDJx6rlqL5WpRQ9X6uQyRbtWW216ZfBIJY+M5+
         VHURdv+mGDAt8p1vG3zluw0KNYbuPHwOZu13bNUCq1S+ZWjfDB+C5XuGmIYZJ8IV8vTw
         i4cBcQZSDDDQ8VfbDUitf73+HcqRQqPOFbqTM0zb4cr9tnO/zLGDBWtp8qLOFQsiXQne
         OTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788146681; x=1788751481;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LqUXShy4Y1uwDBlZFsBdfY3ls/HGLA3gGP5AeZZ/dKE=;
        b=ExCcEzK4YyiaHHi3bNNHeOcyV6IyafXY1rNEa35JDExGkrNd1L9Cho7LkwWb/o/HK9
         LUE5An6IngAfSoc+K+UafMjcY0f9QR22vh5KBlK6XILit5EwD8sYkKsMRuotqzJbI+QB
         W37qSxV2kT9+PmlLr0cqWdXBIyjAGHiap9MrH7oB+RGZNYt0mHFyTdueuXC6tEgJf36d
         gQE3BHA8L7HVgjSnv0qKoNPZxzVGO80xA+QFgBhiZLlS0x7HKVk4zpAZ6q/aciA5c6Pe
         uIzXr5iZ2WLvl3ymwQOEPCRE5r7fC+Kp6wKkzc4hoGAn6rV8iGZDTaM1+rV6/5AzTWvJ
         WMhw==
X-Forwarded-Encrypted: i=1; AKwUvBzlefAkZXtNpZ7clsPUQgS1Dwcewhv3rTTuKqp65q++2motGq2RueJGusGt03QYx4sD5oMI+oHv8rM=@vger.kernel.org
X-Gm-Message-State: AFuF++l8xN7J/qMOpLyO6z3I/sN+YRAWtF/iG8U5ENytiCXjpL5tmJIR
	5dt6ouNyTWcxWpUq6AGvV8WWAk3iOs3C1GrzwRNuxvWAGUUz39dEO/4rAs65iFZrYhFKq6OH2rL
	qnsAcbbjBRacJCryKWj/XnAacMnEHB6avBw==
X-Received: from pjbgw21.prod.google.com ([2002:a17:90b:a55:b0:383:7b51:b1cd])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3d4b:b0:398:9be8:ea6a with SMTP id 98e67ed59e1d1-398f87e4b39mr785477a91.23.1788146681049;
 Sun, 30 Aug 2026 20:24:41 -0700 (PDT)
Date: Mon, 31 Aug 2026 03:24:40 +0000
In-Reply-To: <apSdOnbdLdrJ7ksF@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260830-fix-aer-refcount-leak-v1-1-64e1013add12@google.com> <apSdOnbdLdrJ7ksF@wunner.de>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260831032440.1053206-1-rathodpriyank@google.com>
Subject: Re: [PATCH] PCI/AER: Fix struct pci_dev reference leak in aer_process_err_devices()
From: Priyank Rathod <rathodpriyank@google.com>
To: lukas@wunner.de
Cc: Priyank Rathod <rathodpriyank@google.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	"Oliver O'Halloran" <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Stefan Roese <stefan.roese@mailbox.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Sun, Aug 30, 2026 at 11:14:34PM +0200, Lukas Wunner wrote:
> The "no active error status is read" is the only scenario where
> this *could* happen.  However if no error bits are set in the
> status register, why did the device send an error message upstream
> in the first place?  That would be a broken device.
> 
> Another theoretical possibility would be that the device becomes
> inaccessible by the time aer_get_device_error_info() reads the
> status/mask registers.  They'd both be read as "all ones",
> hence info->status & ~info->mask == 0.

Hi Lukas,

Thanks for the review and clarifying that.

The underlying reference count leak is genuine, but the additional topology
scenarios listed in v1 were inadvertently incorporated from an automated AI
review bot report, which introduced those inaccurate/hallucinated cases.

I have updated this in v2:
- Corrected the Fixes tag to 60271ab044a5 ("PCI/AER: Take reference on error devices").
- Cleaned up the commit description to remove the extra scenarios and focus
  strictly on the actual failure path (device becoming inaccessible / register
  read returning no active unmasked status).

Thanks,
Priyank
