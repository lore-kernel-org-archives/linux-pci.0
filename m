Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C69A2405E1;
	Thu, 18 Jun 2026 03:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781751682; cv=none; b=VqFYSoJvABJFEYF2UwywRit956Poz9k/nKwdBVbjzbJ1saoEHjorj2h5CgCzzS4W9or0PuOgeBAaBpalCU+QqTLm9NL/7hH9WG5pn5oxrYU3lH+D769W5CfYMxqdQmjDubIhLl+2cE8ezwxZG2lt/Qp5T+K3ONdDUPGKJt1qJCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781751682; c=relaxed/simple;
	bh=HjMhz2vk1Uc7wrw+fzjuduW2muUc6ozxTHZSkSZhgtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyYdhSARRRsn1cLK0i/SoRWmKipwOKPZBbkt3TdWN2kTJi9wDoGJQDaEjUeFgj6OQajakFog1M2wRiO1idaN+cQjIUesvu1H5qYrxpclfuW8tvdFwDV0x7IKTVn0lDhZAbl1XNfWfJUrZEyS0Lm/o3Y33pOEqX9sPhnnk2Snk+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNTBzIN0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNTBzIN0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E521F000E9;
	Thu, 18 Jun 2026 03:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781751680;
	bh=V0sVQmvlm7j9KKi1orJx2AQn8Y+bmswv4j9onT+1uJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NNTBzIN0UjikRBMzNJH+/QfMhR5S19NgusniPtnYd2ZN/NV/Iw/y/ZBDxj0pjGwa7
	 k/hZ9mV13/3wn6SVd4qas32/D713zKBZTgaqoI2tlC7vodhUPBgesehOAkVb6YU8bL
	 XdAD5avcpzUoaI18pYLXutFqwhtr1V3k00BQmbKzYGkb0skn9WwDgUbmKkeBJccVDs
	 qPPej3aRPdurMNOi94uPhwVsn3+8njVI2NQTOcwdd9xgnmTDB18F51SDMIR2OZjQN9
	 yAI9uren6uc482IeQyz/zwQL3UjYv9yybiWMmi41DHU/QL52Bcvqm/UvOqy++3X+CS
	 0KX7Y+Tnm9EVQ==
Date: Thu, 18 Jun 2026 12:01:19 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Cc: mani@kernel.org, kishon@kernel.org, arnd@arndb.de, 
	gregkh@linuxfoundation.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] KASAN: slab-use-after-free in pci_endpoint_test_ioctl
Message-ID: <20260618022134.GA1962928@rocinante>
References: <178144969601.60470.7358419009914000395@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178144969601.60470.7358419009914000395@gmail.com>

Hello,

> I hit the following report while testing current upstream kernel:
> 
> KASAN: slab-use-after-free in pci_endpoint_test_ioctl
> 
> I reproduced this on commit: e8c2f9fdadee7cbc75134dc463c1e0d856d6e5c7 (May 25 2026)
> 
> The reproducer and .config files are here.
> https://gist.github.com/shuangpengbai/1e03464adfefbb75fb5d8112691e38b3

The proof-of-concept you have there can be distilled down to:

#include <fcntl.h>
#include <string.h>
#include <sys/ioctl.h>
#include <unistd.h>

#define BDF "0000:XX:YY.Z"

int main(void)
{
	int fd = open("/dev/pci-endpoint-test.0", O_RDWR);
	int u = open("/sys/bus/pci/drivers/pci-endpoint-test/unbind", O_WRONLY);

	if (write(u, BDF, strlen(BDF)) < 0)
		return 1;

	ioctl(fd, 0);
	return 0;
}

Only required steps would be to update the BDF definition with the
relevant device address, and then bind the right device prior to
running the proof-of-concept binary:

  $ echo "1234 0987" > /sys/bus/pci/drivers/pci-endpoint-test/new_id

> [  222.372449][ T8376] Call Trace:
> [  222.372455][ T8376]  <TASK>
> [  222.372460][ T8376]  dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
> [  222.372476][ T8376]  print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
> [  222.372531][ T8376]  kasan_report (mm/kasan/report.c:595)
> [  222.372558][ T8376]  pci_endpoint_test_ioctl (drivers/misc/pci_endpoint_test.c:1145)
> [  222.372604][ T8376]  __se_sys_ioctl (fs/ioctl.c:51 fs/ioctl.c:597 fs/ioctl.c:583)
> [  222.372615][ T8376]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
> [  222.372647][ T8376]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
> [  222.372658][ T8376] RIP: 0033:0x7fd68c893237
> [  222.372668][ T8376] Code: 00 00 00 48 8b 05 59 cc 0d 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 29 cc 0d 00 f7 d8 64 89 01 48
> [  222.372678][ T8376] RSP: 002b:00007ffc1aa73f18 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
> [  222.372693][ T8376] RAX: ffffffffffffffda RBX: 00007fd68c9774c0 RCX: 00007fd68c893237
> [  222.372701][ T8376] RDX: 0000000000000000 RSI: 0000000000005009 RDI: 0000000000000003
> [  222.372707][ T8376] RBP: 0000560e1af360c3 R08: 0000000000000000 R09: 00007ffc1aa73e27
> [  222.372714][ T8376] R10: fffffffffffff64d R11: 0000000000000206 R12: 0000000000000003
> [  222.372719][ T8376] R13: 0000000000005009 R14: 0000000000000000 R15: 00007ffc1aa73f80
> [  222.372731][ T8376]  </TASK>
> [  222.372735][ T8376]
> [  222.392098][ T8376] Freed by task 8376 on cpu 0 at 222.263660s:
> [  222.392729][ T8376]  kasan_save_track (mm/kasan/common.c:57 mm/kasan/common.c:78)
> [  222.393215][ T8376]  kasan_save_free_info (mm/kasan/generic.c:584)
> [  222.393743][ T8376]  __kasan_slab_free (mm/kasan/common.c:253 mm/kasan/common.c:285)
> [  222.394242][ T8376]  kfree (include/linux/kasan.h:235 mm/slub.c:2689 mm/slub.c:6251 mm/slub.c:6566)
> [  222.394657][ T8376]  devres_release_all (drivers/base/devres.c:50 drivers/base/devres.c:547 drivers/base/devres.c:576)
> [  222.395176][ T8376]  device_release_driver_internal (drivers/base/dd.c:598 drivers/base/dd.c:1357 drivers/base/dd.c:1375)
> [  222.395807][ T8376]  unbind_store (drivers/base/bus.c:244)
> [  222.396280][ T8376]  kernfs_fop_write_iter (fs/kernfs/file.c:352)
> [  222.396832][ T8376]  vfs_write (fs/read_write.c:595 fs/read_write.c:688)
> [  222.397273][ T8376]  ksys_write (fs/read_write.c:740)
> [  222.397725][ T8376]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
> [  222.398207][ T8376]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
> [  222.398823][ T8376]
> [  222.399073][ T8376] The buggy address belongs to the object at ffff88811be68400
> [  222.399073][ T8376]  which belongs to the cache kmalloc-512 of size 512
> [  222.400509][ T8376] The buggy address is located 56 bytes inside of
> [  222.400509][ T8376]  freed 512-byte region [ffff88811be68400, ffff88811be68600)

At first glance, it looks like the file descriptor outlives the driver
binding.  An open file descriptor doesn't block unbind via sysfs, and
misc_deregister() doesn't revoke currently open file descriptors either.

The struct pci_endpoint_test has to stay alive until both the driver is
unbound and the last open file descriptor is closed - whichever happens
last, whereas devres frees it as soon as the driver is unbound, regardless
of any file descriptor that is still open.  Hence the dangling reference
and the use-after-free.

Thank you!

	Krzysztof
