Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn3nam01on0114.outbound.protection.outlook.com ([104.47.33.114]:14147
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752222AbdLUTPs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Dec 2017 14:15:48 -0500
From: Casey Leedom <leedom@chelsio.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Does anyone know of a problem with Write Combined Buffer support
 CentaurHauls?
Date: Thu, 21 Dec 2017 19:15:46 +0000
Message-ID: <SN1PR12MB03527687B2D1DC3DD12E8FEBC80D0@SN1PR12MB0352.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

    We have a problem with a system which ~seems~ to be pointing at a broke=
n Write
Combined Buffer implementation.  Our chip seems to be getting garbage data
instead of incomplete Write Combined Merging Transaction Layer Packets.
We'll go ahead and put the beast on a PCIe Analyzer to verify this, but I
thought I'd ask if anyone else had already stumbled across this.

/proc/cpuinfo:
processor       : 0
vendor_id       : CentaurHauls
cpu family      : 6
model           : 15
model name      : C-QuadCore C4600@2.0GHz
stepping        : 14
cpu MHz         : 1332.000
cache size      : 2048 KB
physical id     : 0
siblings        : 4
core id         : 0
cpu cores       : 1
apicid          : 0
initial apicid  : 0
fpu             : yes
fpu_exception   : yes
cpuid level     : 13
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca =
cmov pat pse36 clflush acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1=
gb rdtscp lm constant_tsc rep_good nopl eagerfpu pni pclmulqdq monitor vmx =
est tm2 ssse3 cx16 xtpr pcid sse4_1 sse4_2 movbe popcnt aes xsave avx f16c =
rdrand rng rng_en ace ace_en ace2 phe phe_en pmm pmm_en lahf_lm abm 3dnowpr=
efetch ida dtherm fsgsbase tsc_adjust bmi1 avx2 smep bmi2 invpcid rdseed ad=
x xsaveopt
bogomips        : 3990.44
clflush size    : 64
cache_alignment : 128
address sizes   : 36 bits physical, 48 bits virtual
power management:

processor       : 1
vendor_id       : CentaurHauls
cpu family      : 6
model           : 15
model name      : C-QuadCore C4600@2.0GHz
stepping        : 14
cpu MHz         : 1332.000
cache size      : 2048 KB
physical id     : 0
siblings        : 4
core id         : 0
cpu cores       : 1
apicid          : 1
initial apicid  : 1
fpu             : yes
fpu_exception   : yes
cpuid level     : 13
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca =
cmov pat pse36 clflush acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1=
gb rdtscp lm constant_tsc rep_good nopl eagerfpu pni pclmulqdq monitor vmx =
est tm2 ssse3 cx16 xtpr pcid sse4_1 sse4_2 movbe popcnt aes xsave avx f16c =
rdrand rng rng_en ace ace_en ace2 phe phe_en pmm pmm_en lahf_lm abm 3dnowpr=
efetch ida dtherm fsgsbase tsc_adjust bmi1 avx2 smep bmi2 invpcid rdseed ad=
x xsaveopt
bogomips        : 3990.44
clflush size    : 64
cache_alignment : 128
address sizes   : 36 bits physical, 48 bits virtual
power management:

processor       : 2
vendor_id       : CentaurHauls
cpu family      : 6
model           : 15
model name      : C-QuadCore C4600@2.0GHz
stepping        : 14
cpu MHz         : 1332.000
cache size      : 2048 KB
physical id     : 0
siblings        : 4
core id         : 0
cpu cores       : 1
apicid          : 2
initial apicid  : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 13
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca =
cmov pat pse36 clflush acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1=
gb rdtscp lm constant_tsc rep_good nopl eagerfpu pni pclmulqdq monitor vmx =
est tm2 ssse3 cx16 xtpr pcid sse4_1 sse4_2 movbe popcnt aes xsave avx f16c =
rdrand rng rng_en ace ace_en ace2 phe phe_en pmm pmm_en lahf_lm abm 3dnowpr=
efetch ida dtherm fsgsbase tsc_adjust bmi1 avx2 smep bmi2 invpcid rdseed ad=
x xsaveopt
bogomips        : 3990.44
clflush size    : 64
cache_alignment : 128
address sizes   : 36 bits physical, 48 bits virtual
power management:

processor       : 3
vendor_id       : CentaurHauls
cpu family      : 6
model           : 15
model name      : C-QuadCore C4600@2.0GHz
stepping        : 14
cpu MHz         : 1332.000
cache size      : 2048 KB
physical id     : 0
siblings        : 4
core id         : 0
cpu cores       : 1
apicid          : 3
initial apicid  : 3
fpu             : yes
fpu_exception   : yes
cpuid level     : 13
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca =
cmov pat pse36 clflush acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1=
gb rdtscp lm constant_tsc rep_good nopl eagerfpu pni pclmulqdq monitor vmx =
est tm2 ssse3 cx16 xtpr pcid sse4_1 sse4_2 movbe popcnt aes xsave avx f16c =
rdrand rng rng_en ace ace_en ace2 phe phe_en pmm pmm_en lahf_lm abm 3dnowpr=
efetch ida dtherm fsgsbase tsc_adjust bmi1 avx2 smep bmi2 invpcid rdseed ad=
x xsaveopt
bogomips        : 3990.44
clflush size    : 64
cache_alignment : 128
address sizes   : 36 bits physical, 48 bits virtual
power management:

Casey
