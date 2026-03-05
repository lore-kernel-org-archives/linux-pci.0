Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5862839098C
	for <linux-pci@vger.kernel.org>; Thu,  5 Mar 2026 12:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772714926; cv=none; b=V0jCOMGv23TN3qfrkB8nvy39G9HYTF3Jiv/uyxTPxZ9rFa/vbx7eX8e2dAM+XZRueoj5+Z9g4hxsjdgiYQjgiUsqsb+EH8PJLTqLjxUcnZKbF3TPhfeGkxCXV8efLyl+hmAAjVzV63FFCwGNJvdo5JcGXtcdpoQP1oj3L3fuL6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772714926; c=relaxed/simple;
	bh=xgkABJ9B8ONELAl8NPb+eTgwheFOkrLUjxqole2DWOA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=INX8BzG7lXbcpxpFQiwefbpeHoCXZDqr8sTY9Sj4snTJ1psVslLfiRL1JsPOOTfeyE0dRRbfVc5AA7aYWMU2Urjh8itbV5UgIFwCmaxtfUs1Z8zS4Mli0Ukv0il4KazgErJ0UaYVIr6G9NhS9UX2AjzuQuPTWJvgnQMX1QYtArE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sbRa6229; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sbRa6229"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4837907f535so72845015e9.3
        for <linux-pci@vger.kernel.org>; Thu, 05 Mar 2026 04:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772714924; x=1773319724; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bF3Jt8+kZfWxPSpR81XkdalwEBQNNmKeqG6z7c/Rlac=;
        b=sbRa6229uP6vEd1PU5HQGVzTCTFn87u6W1TzEfF5PGPsNdEMaKtHCyWj85lM8Uxci1
         OhBS7W8Eqe5DdmtKKwF6TO0CDrUJrS4aej5E/zHO/VRR8INSzSY2QbOj6DZd3xKFlmoa
         NWVqwKNQlQaytXWcEejf75wNFU6eTYGfryoJbMumd3q/GEn1+iLhxY1zdonIJGj2hm7o
         dSzJsXt9wpi+atkhVb9F0l9A4D7SKxAJKIHnsCT+G62pka2AO7hkwc0yS84wRet2w5rk
         mgLdlRBfYUzlFOCyqAtdfMOg4w13IU8fC+z5UCGptN9MI5bDFGemXxQI58TaxE9ZSblP
         ubRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772714924; x=1773319724;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bF3Jt8+kZfWxPSpR81XkdalwEBQNNmKeqG6z7c/Rlac=;
        b=CD+i6cLZmRt3Bx+DidFVwpuFbmqUfs5x4XaT1pcNYSbyVJMDDmm92hrQTaq1RaqfEG
         OOtw9EhrY7BcVd0dIXapsreIy/h8Q87dxI2GQUgxdksWpR8PB/9ighHaEU4nzBzNgD3D
         nMA6F4OQqAig2q4iNYddo9VrkMGha1e2iRP4EOHVi0c9O5Iy6xvJo1RbFq9+Lp78nBRw
         9mCF9xBFzFnf9cEyvIXM6T6BsnV3v0YY9AVxuJuJm6O9DSXd93BGM2ja8xYK1Xne9AME
         shY+9bWHUnD6p1h8N3Kn54XnNSt5DjZ8blqmANVUGIcWR9AZH1NFDNY0R2n/cR05906Z
         UOIA==
X-Forwarded-Encrypted: i=1; AJvYcCVTfIrAhCpIK3HrwAh63Pz/yOKHCb+SFsmtTCABofj2twvEykRyFT0H2slixB9D6Ga4izR8Lyfkj/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqxGpQ7UhbJsNOhnfLRUA37ohDRzDphf2f0ZABFKEo3BE9bFum
	VxKkWLobJ0jY5Ss6HGMBUxKbBvWL8jLMF24Ho3yem2MSkykYdGEcxCSze+h5ZM1ne1A=
X-Gm-Gg: ATEYQzw7d5Pe4XKyv5q+eeg9Ux/5qUyoakL9cPTraEgfcfDZDmuhxAJpHxD4e+J5QkP
	VKXgZrMt8E252fS9qak/Xkq6i8Yzd1a99wb01uRDde/O5nISPmA0mevZ/9PBhPikf0nfUucp9hl
	GJLHDpjT44LFSkOdXD8hWmcDcKMm/oxyDiqBivRYd4v3nDlqdON3a2jgo7WG69c0F+BT2a8THH8
	7Hf/U/Ih5pVv0LtabKqv2HYozlbVSiyUYjV36VpgmbTDyUMg19gTSo6+7Ek7tFKe/jB2woAiofu
	TIu/aOCavPjGG1j49/jsfhYY1g3Ju1ockfKTbAa6geoaHU3ghKjXYnqgblY+xVenpHChLDgkI+c
	ODlRbE9JGS4eJFP2a0z0gXGrDenQkqKNUigL/zdWKFvhdfh3deqs8q2g/75LhNCrCjHAV3CCa2K
	yW5s12TLTM2jeXRUSXSYrCjqN0Kht2a4Z7MDEWY5c=
X-Received: by 2002:a05:600c:6389:b0:480:4b5d:9ec with SMTP id 5b1f17b1804b1-485198a3c2cmr91882675e9.33.1772714923573;
        Thu, 05 Mar 2026 04:48:43 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851a895553sm92101715e9.1.2026.03.05.04.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 04:48:43 -0800 (PST)
Date: Thu, 5 Mar 2026 15:48:40 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Farhan Ali <alifm@linux.ibm.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>,
	Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [pci:wip/2603-farhan-s390-err-v10 1/9] drivers/pci/slot.c:40
 address_read_file() warn: impossible condition '(slot->number == -1) =>
 (0-u16max == (-1))'
Message-ID: <202603051816.NIWQx7m0-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git wip/2603-farhan-s390-err-v10
head:   d72875f0a4958f51f7196e6fada9357799418a52
commit: 77c0762d2e847cf2e8d6d79e6f88a1c2b1ca4d06 [1/9] PCI: Allow per function PCI slots
config: i386-randconfig-r071-20260305 (https://download.01.org/0day-ci/archive/20260305/202603051816.NIWQx7m0-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
smatch: v0.5.0-9004-gb810ac53

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202603051816.NIWQx7m0-lkp@intel.com/

smatch warnings:
drivers/pci/slot.c:40 address_read_file() warn: impossible condition '(slot->number == -1) => (0-u16max == (-1))'

vim +40 drivers/pci/slot.c

f46753c5e354b8 Alex Chiang          2008-06-10  38  static ssize_t address_read_file(struct pci_slot *slot, char *buf)
f46753c5e354b8 Alex Chiang          2008-06-10  39  {
77c0762d2e847c Farhan Ali           2026-03-02 @40  	if (slot->number == -1)
                                                            ^^^^^^^^^^^^^^^^^^
u16 can't be -1.

f8cf6e513ec4f0 Krzysztof Wilczyński 2021-06-03  41  		return sysfs_emit(buf, "%04x:%02x\n",
f46753c5e354b8 Alex Chiang          2008-06-10  42  				  pci_domain_nr(slot->bus),
f46753c5e354b8 Alex Chiang          2008-06-10  43  				  slot->bus->number);
f8cf6e513ec4f0 Krzysztof Wilczyński 2021-06-03  44  
f8cf6e513ec4f0 Krzysztof Wilczyński 2021-06-03  45  	return sysfs_emit(buf, "%04x:%02x:%02x\n",
f46753c5e354b8 Alex Chiang          2008-06-10  46  			  pci_domain_nr(slot->bus),
f46753c5e354b8 Alex Chiang          2008-06-10  47  			  slot->bus->number,
f46753c5e354b8 Alex Chiang          2008-06-10  48  			  slot->number);
f46753c5e354b8 Alex Chiang          2008-06-10  49  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

