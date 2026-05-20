Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B031137B02A
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 21:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779311590; cv=none; b=SIdqWbt7lXrTVjINRGQKy7N+G8KxNakik5XjOCyNY8xSrwUH29Xd+lVcgoUbg9SSHL+8yb6phRgGMY26gDWovAnzFGVCt75U/0J6emVfvis65H29xJDcRH0CNPcQeYwfipmlxxreLpd3I+bsoCsMkTmPqTT3lX3OGsojheSuM/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779311590; c=relaxed/simple;
	bh=g3XqxIZVAtiYRCC/Ha11lGANX3W39mRhS+q9W0tVlGQ=;
	h=From:To:Cc:Subject:Date:Message-ID; b=D0OK/m+Uzg5vE55qDSAaLBCL/YWs8uiz0a1oeV0V9cVwJtEk2jm2hVMC9TLVO+EBWD2ZYOntckG9la9ah2zriIKjRmLB/4KOvBsDDy0Li03FqopLme9OkGzGHZwtl8D8KxoP93in/ebLwJ/N0vy+2B0kg5FPG+Ngq9xyKmBnZ5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=fSJ89dqD; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="fSJ89dqD"
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2bd9c3b550aso36487405ad.2
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 14:13:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779311588; x=1779916388;
        h=content-transfer-encoding:message-id:date:subject:cc:to:from
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csEWhLBeuXUIcPbnmNvH2qpT5Hb/mVQdn2helAHeEmE=;
        b=E8VhClWVguooLlLU54IY7iQ345SfGqehUHgMWPecbpmm5JPBFZAdE/OwdpyfFkpfGn
         MqLndujY1Xk/G7HdBe9xKVvnSKvJk9Dd4dN+Mmsv3yAexO0udihZlTGlWYkVabeyhphY
         45du8Zl2P3EJAI2UYa8FMWwUZ2vv6esZX26iB1UOyPL3t7lW4IdCYDuUpicip6UvkSs+
         TvbBp444gbuWY4/znA7mIbg8hUYfElBwuBtSG+NnxfeXpxCGABPKJ9nB2dqzkyoG/NUV
         UAVjRuy9+RRGCmAgsW/N0pe5Y0jl2cZ+7y3KywUmvmiSnQfxrrG1T5s2D/LfUI3tYMO1
         JWSg==
X-Forwarded-Encrypted: i=1; AFNElJ/wuxC+875j7kbvOkCxCYmhr4d1gq8BI63xD/e0KDcjiKg2HxWn4Pt0E6arEcN03Mh20W8XTKoG0Z4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCWOoINCTYPH1udIp25ma2z51l1acaNPLsceRTdNmpx9d6QbhS
	WCY/kqbkvWQ8c6RkcQNZXkLy8IVFKj6CzTlK56BSAE/AJ/uNJjDa9OTfOJncJeLkouD+aAhLH1K
	lb2TS8KYz/p2MiR/KUfibE+QFUAmjkpF2hg==
X-Gm-Gg: Acq92OGSdA/+FJtFSGykqufq7o/R0EL2TCL4zx/4R6cUh1Jh0a33VTYDhJt/XRDmDWr
	ayLSPWBV1MKTppFB2Yq3e8z+q6P1yNa1mX3pU0D7g7Wp/sP7NP7UuGLNfHN6j2dVi3gpWJm6wDB
	/3TcaHU4Svr+rS7TpLSIzLkX2CeavRBOoKtXCgtt2y1qvoNdwD950dDcLSkbcsFu+sw0SbKl4yJ
	zHB5ZD7H/yikVPAfNzqieoHdFFwdxHZvhbxaQUvZHgqjj4USjBxrdRLmdaFdcgnD8L7h/siF70S
	2X8yxt8v/P0EKyp2dpXyIvQcXcdW0uJNFEWxacYrilyzv/lGUdD0S7S5NJ+TsgBGS9FnJd/BBEb
	AM4wUQ0cDU/G8wUcsFoNElfGTcnbC3ampqKuWKYlxcFNbKlNWsgbZ3mqyrOGq5xRqNvoyTMrn12
	mw9MgIyZuu2e+dEgfaWH3zt3CPCbTaPFPZPw==
X-Received: by 2002:a17:903:22c3:b0:2b0:52b7:e82 with SMTP id d9443c01a7336-2bd7e7ef8d9mr288288395ad.16.1779311587845;
        Wed, 20 May 2026 14:13:07 -0700 (PDT)
Received: from smtp.aristanetworks.com (ec2-52-52-135-65.us-west-1.compute.amazonaws.com. [52.52.135.65])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2bd5bd696a0sm16431335ad.9.2026.05.20.14.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 14:13:07 -0700 (PDT)
X-Relaying-Domain: arista.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
	s=Arista-A; t=1779311586;
	bh=csEWhLBeuXUIcPbnmNvH2qpT5Hb/mVQdn2helAHeEmE=;
	h=From:To:Cc:Subject:Date:From;
	b=fSJ89dqD5XhJiv8ZMsb+ggFP9uqIHbgJKba86vK22Lf3822LHygIoxovj/+r4Tiq3
	 /assuztVFA3Qg4eGt3Dj1YP3fj+TkKCHBYAPJFztNCqDFSPlwgfqAX6rFewp3B3J2M
	 WsvWkOnIZe4QpxQFGc9LD7jmJuwWPFb69+7LENu7tKrGyv8LxpLczHpAQY+ZE9seI4
	 wkF/qOPVEkYJAnQS6096ABlmPrAlCIbW8JSzQgGiAw8Y4ryFBN0kDk0Q+psKlsYKaB
	 /OhOOlUtk/YzHjpcott1zEeXjGuF9V8LTfXq1E2BlGls9R5UzY4cMQ8ll55oLqssk+
	 r6TMabOO6bIbA==
Received: from gianfranco-dutka-usb-uas.sjc.aristanetworks.com (dhcp-224-35-225.sjc.aristanetworks.com [10.224.35.225])
	by smtp.aristanetworks.com (Postfix) with ESMTP id 90B67C2B2B;
	Wed, 20 May 2026 21:13:06 +0000 (UTC)
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
From: Gianfranco Dutka <gianfranco.dutka@arista.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gianfranco Dutka <gianfranco.dutka@arista.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI/sysfs: NULL res_attr slot after kfree as defence against double-remove
Date: Wed, 20 May 2026 14:13:06 -0700
Message-ID: <20260520211306.3301893-1-gianfranco.dutka@arista.com>
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

pci_remove_resource_files() frees the bin_attribute pointed at by
pdev->res_attr[i] / pdev->res_attr_wc[i] but does not clear the slot
after kfree().  If pci_remove_sysfs_dev_files() is ever invoked twice
against the same pdev, the second pass dereferences a freed
bin_attribute and faults inside strlen() called from
kernfs_remove_by_name_ns().

To the best of my knowledge no in-tree caller hits this today -- the
primary path (pci_stop_dev() -> pci_remove_sysfs_dev_files()) is
expected to fire once per device -- so this is being submitted as
defence-in-depth rather than as a fix for a reproducer in the upstream
tree.  The motivation is that a freed-but-not-cleared pointer in a
device-lifetime table is a sharp edge: any future caller (in-tree or
out-of-tree) that re-enters the teardown path turns it into a UAF
with no warning.  Other allocator-managed pointer tables in the
kernel NULL the slot after kfree() for exactly this reason, and the
two-line change makes pci_remove_resource_files() idempotent at
essentially zero cost.

For full disclosure: the way I encountered this was via an
out-of-tree PCIe hotplug driver on an AMD Ryzen Embedded V3000
platform.  The driver re-enters pci_stop_and_remove_bus_device()
against a pdev that the standard pci_destroy_dev() path has already
torn down, and with slub_debug=FZPU the second entry faults with the
classic POISON_FREE signature:

  BUG: unable to handle page fault for address: 6b6b6b6b6b6b6b6b
  RIP: strlen+0x4
  Call Trace:
    kernfs_find_ns
    kernfs_remove_by_name_ns
    sysfs_remove_bin_file
    pci_remove_resource_files
    pci_remove_sysfs_dev_files
    pci_stop_bus_device
    pci_stop_and_remove_bus_device
    <out-of-tree hotplug driver remove path>

I am aware that "out-of-tree driver re-enters teardown" is not by
itself a reason to take a change upstream, and I would understand a
NACK on that basis.  The reason I am still sending it is that the
fix is local, mechanical, matches an idiom already used elsewhere in
the kernel, and removes a class of bug rather than papering over the
specific caller that surfaced it.

Signed-off-by: Gianfranco Dutka <gianfranco.dutka@arista.com>
---
 drivers/pci/pci-sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1228,11 +1228,13 @@ static void pci_remove_resource_files(struct pci_dev *pdev)
 		if (res_attr) {
 			sysfs_remove_bin_file(&pdev->dev.kobj, res_attr);
 			kfree(res_attr);
+			pdev->res_attr[i] = NULL;
 		}

 		res_attr = pdev->res_attr_wc[i];
 		if (res_attr) {
 			sysfs_remove_bin_file(&pdev->dev.kobj, res_attr);
 			kfree(res_attr);
+			pdev->res_attr_wc[i] = NULL;
 		}
 	}
 }
--
2.43.0
