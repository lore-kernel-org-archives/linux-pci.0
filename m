Received: from mail-oi2-f16.google.com (mail-oi2-f16.google.com [74.125.231.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A048037187B
	for <linux-pci@vger.kernel.org>; Sun, 20 Sep 2026 19:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.208
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789932728; cv=pass; b=p+sBQOgdb5YkJFvOo+VWN68IHXFN9P2uvm0x7T9Dv3LAuQ31SCqNAL/vEBgWYDbXpuy6A/2pRJZKBL691f8vKniFQ8sL4bP1MIYnU0nHMut8g+FSb3k7FIHJGNby+zI7Bybv0ZxCv8LFl7uEv+6w+q+mKt/D/T3uxXInwTcJa/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789932728; c=relaxed/simple;
	bh=/ZgdHhG5ZvEpFwYaadHDm7cmTHzQDuah+Z/Y+QdMfak=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=U5nGOuJ8+qGhBnmxPlA+bVgniRcoYVmQNqeCPY2lJvctWkpwSWhqhdAnC8URCpLObpt3ik/wqNBGCr8/Qy8h9Yjdtb3xfEuBB3OTnDUYKC1qlhpZey3Z0E90kzQOTpRIwIu4dcax75r32WNYgGchwbY3krXJyUkkxJuv+2X6uek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clzlaSq8; arc=pass smtp.client-ip=74.125.231.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clzlaSq8"
Received: by mail-oi2-f16.google.com with SMTP id 46e09a7af769-7f4f0c89e35so1624013a34.2
        for <linux-pci@vger.kernel.org>; Sun, 20 Sep 2026 12:32:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789932725; cv=none;
        d=google.com; s=arc-20260327;
        b=U27/HIhKRHkb95LxD9sFPqmAG++7Q03RA1S1GJ9dZjg3b4gEOb7Opa8j9YYMrHszlY
         SFiZURl70UTWM89f1R5f1mNlIVXMlRq4jVtjaO78l/+jzZMbmSLK2R/v1c77/KNbu543
         71KraH1cZWLn2XU6TvRBScqvTAgzjmqlb9BjsTRZB5M2frbGDy/fSZAJAgztBt+gvKmA
         bVEsxoMaTc+Zw8N6ud08IcwFSz787CTHhnc0LTnk8uhsdzNMVOAy+9LPKJqNHwAi8z+4
         HNDzwK1S+zO3HNuOJ1jHm9UEn1aegJR3hdSGmOrrIeswx7dFJNYxp+xFH1gs7qKFgF7E
         0vJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=lKJjgfv0X/+uSvuTAQeMccT1m4OGFd/PKehQb6AA+ZM=;
        fh=EfujMstWYmdFvPeCBAhLBiPi7yWFoNM15oJi8Rh/J0k=;
        b=ZsBxrOjsd/AwDydMEIQq9ghlCOWGYF8KwjUawD2DoxSZv4jWQ9ax1xgiOg2FkqWX4u
         o7Mxw+J7FNqsVN4N/TL3riVkvUV5ZkjkcLrRJtpMf0Rbst/UmFLbx7XhHLVvI5CoXpUA
         gK+kUj9wwRJycfEujov6BzsXPspI2yVksWcnBvdataZ/lkiLUtbLQNQ7nNJ5j5BbbZie
         psaZYTWnza3RoSxtHLS0D9dhdMAvpzIWK6JKwVrQeY/uEZqjb5i7p96CwWKBPXtPdJ+t
         lXhtqLrzG8EPZip0xqbBixrIlnlveTAyXyXYv6XD58oJchcgnlmDtChUwB92H4EaH72m
         LktA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789932725; x=1790537525; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=lKJjgfv0X/+uSvuTAQeMccT1m4OGFd/PKehQb6AA+ZM=;
        b=clzlaSq8+Zp/M/9pSixVGpSwk4R0NgTLw9vcKQUrcw0LcCez7UZwYIWPjfB8JVjiAS
         CNmY9ZHdxVjwB4Y8i6bb4I0KR4PQysjy/3vFdR1oMOAg37wfBbj74I4gE+ONzSkIiull
         Q3BdANLFdXDUt73hw/8mCk/E53xEpvyjGyl0XVkVAbLXERUyxyNg/UH3HOHQlHNbs7kl
         Za1loyVI64hwNdyH9Vw7Wmt5uQq0dRAofCWOptbz/r6vQQ2LhFFG+Q/5zEIeYrv1rnKX
         pFwmFDxHKlRHIqpcVSRkJ5ApPgumpN6qMw4/QRYfeBERcl096JmCyszEQhh8ga7iuhYH
         U0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789932725; x=1790537525;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lKJjgfv0X/+uSvuTAQeMccT1m4OGFd/PKehQb6AA+ZM=;
        b=QfdngFMNe/5kyqveuaTxlpd6S7ycEO6b70EX+QAsBDxtII11FSJ+zK62b/qzSJJDoB
         QirmB/EqrEUJ6w7kBWa0aFiDvQUOYkofCYS0PMW1pBkCx1UHyxbnRQHYMxpqTzoNgbBr
         OpKDSRMO3WwwuARmq61ibUaG34xqzNaV5fUJzeR0Ij9mvMY3oewWeiKbTiG1qG3POzga
         8ENM8YiualQ+zowAxGPcDacuk+K9MAxceceDruFYAWBllbEubQj0WtS0VyzjYN7qjcAD
         OSVXG02ixXkT49mTlArbODlzKlmWbetUcOzbQb9iqpD/Ij/L+hMnfL/uPBlohLjGZbHd
         MAuA==
X-Gm-Message-State: AFuF++lnxU9Mi7px6PeTNnh+dI6CYtxY/E1HQd+8BwMksqkAngmroUGF
	C5vHDYth1NaEE40LlS3VZIZsyj3xOeALH5LhOcaYieLUfMIIb4dC3N6bCduDJOSZYV7x2bBcjgz
	IlvL7fVb/jYW59mBVV3UajvjSs8qHaX922fzsWyx22Q==
X-Gm-Gg: AYBFou1pLo7LmMiQJkeYt4oHA+wR+5cApYK9NtLjVOkNRb2SoJ3khDX6uvko6J7YYyB
	sCyAQJwH2K/h0NQ3a2wrdc1x5gG+ciJm4wyXpNOS3yLhsCAU9bw3hu7cU4es5rnz1TgBe69ZGzU
	I2vAypeCz7mV4GyuF7KfJA+LEA8zK7PGS4Ulz0OtOk3+YQyR41/wwHQOvXhMoox3Cd1VpC/WFDm
	djCDG/JiTJhXhAIWKvvziLA5Za1CowI8GSH3J1x3+5D+QcHOKewz0l9ab5FmOqxohYxUo5RzQEL
	k2hFyS0NDwUtcHv6V9oCH770JIItJd1uQa4FE5dFk8BuvDRBjdHsqhvYeLMN5hN1kVCVrKFtmh/
	4MxC8xCdLmpuVF7G+vX9sPuWxqZuKYyBJb19C/4VXqm2ZjQ5WIm9Hs0GI5PPLbP58HpmyAFV1fJ
	BuaHJldcd2QzEbJCrxwyZ59d4s8Z3YiZmUIfTeoKxaA6az7C46ep5vwGw=
X-Received: by 2002:a05:6830:640c:b0:7f4:eb76:881d with SMTP id
 46e09a7af769-80de0556ff0mr10822439a34.5.1789932725265; Sun, 20 Sep 2026
 12:32:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dalbir Singh <dalbirrana838@gmail.com>
Date: Sun, 20 Sep 2026 20:31:53 +0100
X-Gm-Features: AcwNN1WSUDDF-jP60ubQ849Z2AVsWX_8mIo_mikEZj_Tku7C46r5JKFPH_JqiPo
Message-ID: <CAAJFZSbAOobDfu-2WLW7DKumRyQ=z6hdX5BgPn8iVyvXCaLd_w@mail.gmail.com>
Subject: [PCI/AER] Gen5 Receiver Error / Replay Timeout interpretation and
 possible ARL068 relevance
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I am investigating an intermittent PCIe issue on a Dell Pro Max 16
Plus MB16250 equipped with an Intel Core Ultra 9 285HX processor, and
would appreciate guidance on interpreting the AER evidence.

There are two separate sets of observations.

Historical Windows WHEA Event 17 records on the SSD-to-Intel root-port
path include PCIe Receiver Error, Bad TLP and Bad DLLP reporting.
These records predate my later Linux lane-margining experiments.

During subsequent Linux testing I have also observed AER around some
active PCIe Lane Margining at the Receiver (`pcilmr`) tests.

Examples include:

* GPU root port: Correctable Error Status `0x1101`

  * Receiver Error
  * Replay Number Rollover
  * Replay Timer Timeout

* SSD root port: Correctable Error Status `0x1001`

  * Receiver Error
  * Replay Timer Timeout

Some of these Linux events occurred while receiver
margining/retraining was actively taking place, so I do not want to
incorrectly treat them as evidence of an ordinary operational fault.

The Intel host-side receivers also report:

`Independent Error Sampler: 0`

I am therefore trying to understand how much AER activity may
reasonably be expected as a consequence of active lane margining on
such an implementation.

Separately, I noticed Intel erratum ARL068, concerning a PCIe Gen5
link potentially failing to exit an L1 low-power sub-state under
particular conditions.

I am not claiming that ARL068 explains this system. I have not
demonstrated the stated triggering conditions or the documented
machine-check signature.

I would appreciate guidance on the following:

1. Are Receiver Error / Replay Timer Timeout / Replay Number Rollover
events expected or possible while actively performing PCIe Lane
Margining, particularly where the receiver reports no independent
error sampler?

2. Would you treat AER generated during an active margining/retraining
test differently from the same status appearing during ordinary
workload with margining inactive?

3. For an intermittent SSD/root-port problem involving historical
Receiver Error, Bad TLP and Bad DLLP reporting, what Linux trace or
counters would be most useful to capture during an actual user-visible
slowdown or freeze?

4. Regarding ARL068, is there anything observable through Linux
PCI/AER or power-management telemetry that would help distinguish that
erratum from a more conventional PCIe link/channel problem? Is the
documented machine-check signature effectively necessary before
considering ARL068 a serious candidate?

There is also a separate pciutils issue, `pciutils/pciutils#238`,
concerning a possible ASPM Link Control restore-mask mismatch in
`pcilmr`. I am treating that as a diagnostic-tool issue and am not
assuming that it caused the historical errors described above.

I can provide complete `lspci -vv`, AER status/counter captures, raw
`pcilmr` output, topology and kernel logs if useful.

Separately, I noticed Intel erratum ARL068, concerning a PCIe Gen5
link potentially failing to exit an L1 low-power sub-state under
particular conditions.

Intel reference:
https://edc.intel.com/content/www/us/en/design/products/platforms/details/arrow-lake-s/core-ultra-200s-series-processors-specification-update/errata-details/

I am not claiming that ARL068 explains this system. I have not
demonstrated the stated triggering conditions or the documented
machine-check signature.

Thanks for any guidance.

Regards,

Dalbir Rana
