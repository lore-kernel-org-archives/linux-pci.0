Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAEA38E8BF
	for <linux-pci@vger.kernel.org>; Sat, 16 May 2026 12:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778933815; cv=none; b=mR5fZNxiGlIwdiP8ci+H5i+wOp4JxiF3BeQapbazvTW/SXdUCIaEpnqzqu6c9ubFCcbUjeuH4/7Fmg7nxJbHP9G1+CNEgLthm7vPH/1FTZpf6xuq4IUMnZBQVZtvtO8mg+y80e7dSzN+y08JtZCDBcYHNgH/kMPNZxiO+bfQFBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778933815; c=relaxed/simple;
	bh=f1jHgC9tPzmoEYIaUyX4Mdzf1vB7YwkW0SzcfC6Dr9I=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:From:To:Cc:
	 References:In-Reply-To; b=bg42C92p+TquT+Ge0yv3xmgGyLh8Yx5Ckr68KQii8FM5xwG+hy+2A0cqQGu0Ydo6SCTP248kyrKaPHFal2oovn8zXiubDl15r6MUSG8hRngEqOBLG1Whg0VornnEeMoD68Fp6kZb0ru25dNx8LfDRyfXF/R5NngMfMrGt+1JtUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=dittrich.m@gmx.net header.b=Y26k9ciF; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=dittrich.m@gmx.net header.b="Y26k9ciF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1778933792; x=1779538592; i=dittrich.m@gmx.net;
	bh=MIziYDTNhQKOSBjlAsWR74ydfVqHa5D86CQjJBWYJH0=;
	h=X-UI-Sender-Class:Content-Type:Message-ID:Date:MIME-Version:
	 Subject:From:To:Cc:References:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Y26k9ciFoXw5Euzk4K7ZpZTFRhTl0Non3T4CzxdbTaJr5Uk9RsLMZTZPhN0fBFso
	 XuaAtGnU6bQlX+IvtsDzhq/Nn5t3DWJ/mDqi4wZH6xWp80JpJJnM+PfserSzESiuF
	 vw50Ijiz82vnqEA5EMl+dYVuvZVwPzYn3NBFKG/2sj0j/Q+JX7aS3dohxtjR7ZFXG
	 vMNuoFpRGOF6FOXlA7eoHR4+K41ywVIz0G2Gz2gTyG421cu92zVPfq4uVP1Cgo2RH
	 m501rLGuYmfVm/vtz/B9CqvSZMEt55jbKtC3hCd5aE6y97EK1BC+TRGXj0y3rw9J2
	 HW7qDLh4kPbFgP0IIw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M8QS8-1wSdnM0OmG-00FG3O; Sat, 16
 May 2026 14:16:32 +0200
Content-Type: multipart/mixed; boundary="------------Gb6XiQ5ZQS0IfI3wtOfFmIoh"
Message-ID: <5f716613-d996-46db-96ec-6c0251219922@gmx.net>
Date: Sat, 16 May 2026 12:16:28 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] PCI BAR allocation/D3cold failure: NVIDIA MX250
 inaccessible since Kernel 6.x on Acer Swift 3 (SF314-56G)
From: Matthias Dittrich <dittrich.m@gmx.net>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 regressions@lists.linux.dev, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>
References: <20260501165542.GA491695@bhelgaas>
 <561131dd-0e42-437a-9724-a036238a9bb4@gmx.net>
Content-Language: de-DE
In-Reply-To: <561131dd-0e42-437a-9724-a036238a9bb4@gmx.net>
X-Provags-ID: V03:K1:9VyUxTTS8jpmI2YI/dVxiE15wDVtLrkzucZ1z9gSEtdE/5oToIl
 r+QgiN9d+wkWlcO610dNfpBQTdi9JAiyhelmcEcyPi8gkSyrTKER8cyfPMMXATsm+Pslekp
 /z9QvSvRbtgxEyA559qCI9oWoG5CKOyc6dKT/+GQK/5A4tdGbUQ7c6/kQtZQESUU7j4dRJU
 dKsnxaeFObgnyiRTsH9yQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:S9TvPzdRtdo=;pOo72Dik8lfUnpTn9mZAhYuPqCH
 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
 OoP9f3w==

This is a multi-part message in MIME format.
--------------Gb6XiQ5ZQS0IfI3wtOfFmIoh
Content-Type: multipart/alternative;
 boundary="------------0GulcH7rlDymQw5xhJK1j89g"

--------------0GulcH7rlDymQw5xhJK1j89g
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Dear Bjorn,

I completed the bisect test between kernel 5.15 und 5.16 and found the=20
commit and now have reproducible revert-test results. I used the=20
bisect.sh (attached ) for automation. Testing criteria was status rev ff=
=20
(bad) or rev a1 (good).=C2=A0 As it was the first indicator for me on Ubun=
tu.=20
I also used olddefconfig as I know this config worked before.



The identified commit (see final-bisect-log.txt) is:
# first bad commit: [a1224f34d72a103829d6953935d6c6621f135b83] ACPI: PM:=
=20
Check states of power resources during initialization

Additionally testing (see Abschlusstest.txt):

  * Verification with=C2=A0Parent commit test: git checkout
    a1224f34d72a103829d6953935d6c6621f135b83~1
      o lspci reports `rev a1` and=C2=A0 `nvidia-smi` works correctly
  * Revert test on 5.16 with=C2=A0git revert --no-commit
    a1224f34d72a103829d6953935d6c6621f135b83
       o =C2=A0 =C2=A0 lspci reports `rev a1` and=C2=A0 `nvidia-smi` works=
 correctly
  * Revert test on 6.1 with=C2=A0git revert --no-commit
    a1224f34d72a103829d6953935d6c6621f135b83
      o lspci reports `rev a1` and=C2=A0 `nvidia-smi` works correctly

With kernels like 6.2 and newer "git revert" result in an error and=20
stops (transleted to english):

git revert --no-commit a1224f34d72a103829d6953935d6c6621f135b83=20
Auto-merging drivers/acpi/power.c CONFLICT (content): Merge conflict in=20
drivers/acpi/power.c error: could not revert a1224f34d72a... (ACPI: PM:=20
Check states of power resources during initialization) Hint: After=20
resolving the conflicts, mark the corrected paths with: Hint: 'git add=20
<paths>' or 'git rm <paths>'

All tests have been done with Ubuntu 22.04.

Let me know if I can test anything further.


Test summary Ubuntu:

Test Case

=09

Kernel / Commit

=09

Modification

=09

PCI State

=09

|Nvidia-smi/
NVIDIA Driver|

=09

Result

Baseline good
Ubuntu 22.04

=09

Linux 5.15

=09

none

=09

|rev a1|

=09

works

=09

GOOD

Baseline bad

=09

Linux 5.16

=09

none

=09

|rev ff|

=09

fails

=09

BAD

Bisect parent

=09

|a1224f34...~1|

=09

none

=09

|rev a1|

=09

works

=09

GOOD

First bad commit

=09

|a1224f34...|

=09

none

=09

|rev ff|

=09

fails

=09

BAD

Revert verification

=09

|a1224f34...|

=09

reverted

=09

|rev a1|

=09

works

=09

GOOD

Forward revert test

=09

Linux 6.1

=09

reverted

=09

|rev a1|

=09

works

=09

GOOD

Ubuntu 22.04 (standard)

=09

Linux 6.8

=09

none

=09

|rev ff|

=09

fails

=09

BAD

Modern revert attempt

=09

Linux 6.2

=09

revert attempted

=09

conflict in |drivers/acpi/power.c|

=09

n/a

=09

not testable

*Linux 5.15 is the standard in Ubuntu 20.04 but also available as=20
downgrade in Ubuntu 22.04

Test summary CachyOS:

Test Case

=09

Kernel / Commit

=09

Modification

=09

PCI State

=09

|Nvidia-smi/
NVIDIA Driver|

=09

Result

Standard

=09

Linux 7.0.2

=09

none

=09

|rev a1|

=09

fails

=09

BAD

LTS

=09

Linux 6.18

=09

none

=09

|rev a1|

=09

fails

=09

BAD

Start parameter

=09

|Linux ||7.0.2|

=09

start parameter

=09

|-|

=09

fails

=09

BAD

git

=09

|Linux ||5.15|

=09

none

=09


=09


=09

not testable system freeze

git

=09

|Linux ||7.0.2|

=09

revert attempted

=09


=09


=09

not testable


Kind regards,
Matthias

Am 11.05.2026 um 11:34 schrieb Matthias Dittrich:
>
> Dear Bjorn,
>
> Thank you for the quick response. For transparency, I used the AI tool=
=20
> Gemini during the bug-fixing and testing process. I am not an IT=20
> specialist and therefore cannot fully verify all of the AI=E2=80=99s=20
> conclusions in my last mail.
>
> All kernels were tested manually by installing the OS and kernel. The=20
> recommended boot parameters were also tested manually. The logs sent=20
> previously and in this mail are raw terminal outputs generated from=20
> the commands listed in the "Skript" file.
>
>
> The dmesg and |lspci|output from the newest CachyOS kernel is=20
> attached.=C2=A0Additionally, the following commands were also run for th=
e=20
> Ubuntu 5.15 kernel for comparison:
>
> dmesg
> sudo lspci -vv > lspci-vv-ubuntu2205-K515-good.txt
> sudo lspci -vvv > lspci-vvv-ubuntu2205-K515-good.txt
> sudo lspci -vvxxxx > lspci-vvxxxx-ubuntu2205-K515-good.txt
> sudo lspci -s 02:00.0 -vvxxxx > lspci_gpu_$(uname -r).txt
> sudo lspci -t > lspci_tree_$(uname -r).txt
>
>
> Gemini recommended performing a git bisect with optimized parameters=20
> to reduce compilation time.
>
>   * Before starting the bisect tests, I tested different kernel
>     revisions. The "git" kernel 5.15 (with localmodconfig) appears to
>     work just like the newer Ubuntu 5.15 kernel, as the graphics card
>     status is shown as |(rev a1)|. The earliest kernel revision where
>     the status changes to |(rev ff)|starts with kernel 5.16 (tested
>     with localmodconfig). However, the NVIDIA driver itself could not
>     be tested.
>   * The bisect between 5.15 and 5.16 result
>     in|=C2=A0[342a67f0884293639bd17ea44df754ead799e669]||=C2=A0NFS: Labe=
l the
>     dentry with a verifier in nfs_link(), nfs_symlink()|, which seems
>     incorrect, as the verification using |git checkout
>     342a67f0884293639bd17ea44df754ead799e669~1|also failed.
>   * An automated bisect was attempted without localmodconfig, but
>     there were technical issues and I have not yet been able to
>     complete the testing.
>
> I also noticed that the |lspci|results differ between CachyOS and Ubuntu=
:
>
> 02:00.0 3D controller: NVIDIA Corporation GP108M [GeForce MX250] (rev a1=
)
>
>   * |(rev a1)|=E2=80=94 Ubuntu 22.04 Kernel 5.15 (works), CachyOS Kernel=
 6.1
>     LTS and Kernel 7, but NVIDIA MX150 does not work
>   * |(rev ff)|=E2=80=94 Ubuntu 22.04 Kernel 5.16 and newer (localmodconf=
ig)
>     and Kernel 6.8 and NVIDIA MX150 does not work
>
> Kind regards,
> Matthias
>
>
>
> Am 01.05.2026 um 18:55 schrieb Bjorn Helgaas:
>> [+cc Ilpo]
>>
>> On Fri, May 01, 2026 at 10:13:41AM +0200, Matthias Dittrich wrote:
>>> Dear Kernel Developers,
>>>
>>> I found a regression and did my best to identify the issue and find a
>>> workaround, but I am not a developer. I also published the regression =
in the
>>> NVIDIA Linux Developer Forum, but it appears to be a kernel regression=
 and
>>> not a driver issue, as the latest drivers work on older kernels (e.g.,=
 5.15)
>>> but fail on anything 6.x+. I did not perform a git bisect as compiling=
 on
>>> this i5-8265U - because of its low performance I can only compile one =
kernel
>>> over night.
>>>
>>> **Description:**
>>> The NVIDIA MX250 GPU on Acer Swift 3 (SF314-56G / BIOS 1.14) is inacce=
ssible
>>> on any Linux distribution using Kernel 6.x or 7.x. The device fails to
>>> initialize during the driver probe routine.
>> Thanks for the report.  With the newest kernel available to you, can
>> you please capture the complete dmesg and output of "sudo lspci -vv"?
>> Don't filter out things that don't seem relevant; we can easily do
>> that.
>>
>> Bjorn

--------------0GulcH7rlDymQw5xhJK1j89g
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF-=
8">
  </head>
  <body>
    <p>Dear Bjorn,</p>
    <p>I completed the bisect test between kernel 5.15 und 5.16 and
      found
      the commit and now have reproducible revert-test results. I used
      the
      bisect.sh (attached ) for automation. Testing criteria was status
      rev
      ff (bad) or rev a1 (good).=C2=A0 As it was the first indicator for m=
e
      on Ubuntu. I also used olddefconfig as I know this config worked
      before.</p>
    <p><br>
      <br>
      The identified commit (see final-bisect-log.txt) is:<br>
      # first bad commit: [a1224f34d72a103829d6953935d6c6621f135b83]
      ACPI: PM: Check states of power resources during initialization</p>
    <p>Additionally testing (see Abschlusstest.txt):</p>
    <ul>
      <li>Verification with=C2=A0Parent commit test: git checkout
        a1224f34d72a103829d6953935d6c6621f135b83~1</li>
      <ul>
        <li>lspci reports `rev a1` and=C2=A0 `nvidia-smi` works correctly<=
/li>
      </ul>
      <li>Revert test on 5.16 with=C2=A0git revert --no-commit
        a1224f34d72a103829d6953935d6c6621f135b83</li>
      <ul>
        <li>=C2=A0 =C2=A0 lspci reports `rev a1` and=C2=A0 `nvidia-smi` wo=
rks correctly</li>
      </ul>
      <li>Revert test on 6.1 with=C2=A0git revert --no-commit
        a1224f34d72a103829d6953935d6c6621f135b83</li>
      <ul>
        <li>lspci reports `rev a1` and=C2=A0 `nvidia-smi` works correctly<=
/li>
      </ul>
    </ul>
    <p>With kernels like 6.2 and newer "git revert" result in an error
      and stops (transleted to english):<br>
      <br>
      git revert --no-commit a1224f34d72a103829d6953935d6c6621f135b83
      Auto-merging drivers/acpi/power.c
      CONFLICT (content): Merge conflict in drivers/acpi/power.c
      error: could not revert a1224f34d72a... (ACPI: PM: Check states of
      power resources during initialization)
      Hint: After resolving the conflicts, mark the corrected paths
      with:
      Hint: 'git add &lt;paths&gt;' or 'git rm &lt;paths&gt;'</p>
    <p>All tests have been done with Ubuntu 22.04.=C2=A0</p>
    <p>Let me know if I can test anything further.</p>
    <p><br>
    </p>
    <p>Test
      summary Ubuntu:</p>
    <table width=3D"643" cellpadding=3D"2" cellspacing=3D"0">
      <colgroup><col width=3D"90"> <col width=3D"88"> <col width=3D"94"> <=
col
          width=3D"150"> <col width=3D"136"> <col width=3D"59"> </colgroup=
><thead>
        <tr>
          <th width=3D"90" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">Test Case</font><=
/p>
          </th>
          <th width=3D"88" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">Kernel / Commit</=
font></p>
          </th>
          <th width=3D"94" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">Modification</fon=
t></p>
          </th>
          <th width=3D"150" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">PCI State</font><=
/p>
          </th>
          <th width=3D"136" style=3D"border: none; padding: 0in">
            <p><code class=3D"western"><font size=3D"1"
                  style=3D"font-size: 8pt">Nvidia-smi/<br>
                  NVIDIA Driver</font></code></p>
          </th>
          <th width=3D"59" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">Result</font></p>
          </th>
        </tr>
      </thead> <tbody>
        <tr>
          <td width=3D"90" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">Baseline good<br>
                Ubuntu 22.04</font></p>
          </td>
          <td width=3D"88" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">Linux 5.15</font>=
</p>
          </td>
          <td width=3D"94" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">none</font></p>
          </td>
          <td width=3D"150" style=3D"border: none; padding: 0in">
            <p><code class=3D"western"><font size=3D"1"
                  style=3D"font-size: 8pt">rev a1</font></code></p>
          </td>
          <td width=3D"136" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">works</font></p>
          </td>
          <td width=3D"59" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">GOOD</font></p>
          </td>
        </tr>
        <tr>
          <td width=3D"90" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">Baseline bad</fon=
t></p>
          </td>
          <td width=3D"88" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">Linux 5.16</font>=
</p>
          </td>
          <td width=3D"94" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">none</font></p>
          </td>
          <td width=3D"150" style=3D"border: none; padding: 0in">
            <p><code class=3D"western"><font size=3D"1"
                  style=3D"font-size: 8pt">rev ff</font></code></p>
          </td>
          <td width=3D"136" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">fails</font></p>
          </td>
          <td width=3D"59" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">BAD</font></p>
          </td>
        </tr>
        <tr>
          <td width=3D"90" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">Bisect parent</fo=
nt></p>
          </td>
          <td width=3D"88" style=3D"border: none; padding: 0in">
            <p><code class=3D"western"><font size=3D"1"
                  style=3D"font-size: 8pt">a1224f34...~1</font></code></p>
          </td>
          <td width=3D"94" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">none</font></p>
          </td>
          <td width=3D"150" style=3D"border: none; padding: 0in">
            <p><code class=3D"western"><font size=3D"1"
                  style=3D"font-size: 8pt">rev a1</font></code></p>
          </td>
          <td width=3D"136" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">works</font></p>
          </td>
          <td width=3D"59" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">GOOD</font></p>
          </td>
        </tr>
        <tr>
          <td width=3D"90" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">First bad commit<=
/font></p>
          </td>
          <td width=3D"88" style=3D"border: none; padding: 0in">
            <p><code class=3D"western"><font size=3D"1"
                  style=3D"font-size: 8pt">a1224f34...</font></code></p>
          </td>
          <td width=3D"94" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">none</font></p>
          </td>
          <td width=3D"150" style=3D"border: none; padding: 0in">
            <p><code class=3D"western"><font size=3D"1"
                  style=3D"font-size: 8pt">rev ff</font></code></p>
          </td>
          <td width=3D"136" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">fails</font></p>
          </td>
          <td width=3D"59" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">BAD</font></p>
          </td>
        </tr>
        <tr>
          <td width=3D"90" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">Revert verificati=
on</font></p>
          </td>
          <td width=3D"88" style=3D"border: none; padding: 0in">
            <p><code class=3D"western"><font size=3D"1"
                  style=3D"font-size: 8pt">a1224f34...</font></code></p>
          </td>
          <td width=3D"94" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">reverted</font></=
p>
          </td>
          <td width=3D"150" style=3D"border: none; padding: 0in">
            <p><code class=3D"western"><font size=3D"1"
                  style=3D"font-size: 8pt">rev a1</font></code></p>
          </td>
          <td width=3D"136" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">works</font></p>
          </td>
          <td width=3D"59" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">GOOD</font></p>
          </td>
        </tr>
        <tr>
          <td width=3D"90" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">Forward revert te=
st</font></p>
          </td>
          <td width=3D"88" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">Linux 6.1</font><=
/p>
          </td>
          <td width=3D"94" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">reverted</font></=
p>
          </td>
          <td width=3D"150" style=3D"border: none; padding: 0in">
            <p><code class=3D"western"><font size=3D"1"
                  style=3D"font-size: 8pt">rev a1</font></code></p>
          </td>
          <td width=3D"136" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">works</font></p>
          </td>
          <td width=3D"59" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">GOOD</font></p>
          </td>
        </tr>
        <tr>
          <td width=3D"90" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">Ubuntu 22.04
                (standard)</font></p>
          </td>
          <td width=3D"88" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">Linux 6.8</font><=
/p>
          </td>
          <td width=3D"94" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">none</font></p>
          </td>
          <td width=3D"150" style=3D"border: none; padding: 0in">
            <p><code class=3D"western"><font size=3D"1"
                  style=3D"font-size: 8pt">rev ff</font></code></p>
          </td>
          <td width=3D"136" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">fails</font></p>
          </td>
          <td width=3D"59" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">BAD</font></p>
          </td>
        </tr>
        <tr>
          <td width=3D"90" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">Modern revert
                attempt</font></p>
          </td>
          <td width=3D"88" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">Linux 6.2</font><=
/p>
          </td>
          <td width=3D"94" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">revert attempted<=
/font></p>
          </td>
          <td width=3D"150" style=3D"border: none; padding: 0in">
            <p><font size=3D"2" style=3D"font-size: 10pt">conflict in </fo=
nt><code
                class=3D"western"><font size=3D"1" style=3D"font-size: 8pt=
">drivers/acpi/power.c</font></code></p>
          </td>
          <td width=3D"136" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">n/a</font></p>
          </td>
          <td width=3D"59" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">not testable</fon=
t></p>
          </td>
        </tr>
      </tbody>
    </table>
    <p lang=3D"en-US">
      *<font size=3D"1" style=3D"font-size: 8pt">Linux 5.15 is the standar=
d
        in
        Ubuntu 20.04 but also available as downgrade in Ubuntu 2</font><fo=
nt
        size=3D"1" style=3D"font-size: 8pt">2</font><font size=3D"1"
        style=3D"font-size: 8pt">.04</font></p>
    <p>Test summary CachyOS:</p>
    <table width=3D"643" cellpadding=3D"2" cellspacing=3D"0">
      <colgroup><col width=3D"90"> <col width=3D"88"> <col width=3D"94"> <=
col
          width=3D"150"> <col width=3D"136"> <col width=3D"59"> </colgroup=
><thead>
        <tr>
          <th width=3D"90" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">Test Case</font><=
/p>
          </th>
          <th width=3D"88" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">Kernel / Commit</=
font></p>
          </th>
          <th width=3D"94" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">Modification</fon=
t></p>
          </th>
          <th width=3D"150" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">PCI State</font><=
/p>
          </th>
          <th width=3D"136" style=3D"border: none; padding: 0in">
            <p><code class=3D"western"><font size=3D"1"
                  style=3D"font-size: 8pt">Nvidia-smi/<br>
                  NVIDIA Driver</font></code></p>
          </th>
          <th width=3D"59" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">Result</font></p>
          </th>
        </tr>
      </thead> <tbody>
        <tr>
          <td width=3D"90" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">Standard</font></=
p>
          </td>
          <td width=3D"88" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">Linux 7.0.2</font=
></p>
          </td>
          <td width=3D"94" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">none</font></p>
          </td>
          <td width=3D"150" style=3D"border: none; padding: 0in">
            <p><code class=3D"western"><font size=3D"1"
                  style=3D"font-size: 8pt">rev a1</font></code></p>
          </td>
          <td width=3D"136" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">fails</font></p>
          </td>
          <td width=3D"59" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">BAD</font></p>
          </td>
        </tr>
        <tr>
          <td width=3D"90" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">LTS</font></p>
          </td>
          <td width=3D"88" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">Linux 6.18</font>=
</p>
          </td>
          <td width=3D"94" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">none</font></p>
          </td>
          <td width=3D"150" style=3D"border: none; padding: 0in">
            <p><code class=3D"western"><font size=3D"1"
                  style=3D"font-size: 8pt">rev a1</font></code></p>
          </td>
          <td width=3D"136" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">fails</font></p>
          </td>
          <td width=3D"59" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">BAD</font></p>
          </td>
        </tr>
        <tr>
          <td width=3D"90" height=3D"10" style=3D"border: none; padding: 0=
in">
            <p><font size=3D"1" style=3D"font-size: 8pt">Start parameter</=
font></p>
          </td>
          <td width=3D"88" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt"><code
                  class=3D"western">Linux </code><code class=3D"western">7=
.0.2</code></font></p>
          </td>
          <td width=3D"94" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">start parameter</=
font></p>
          </td>
          <td width=3D"150" style=3D"border: none; padding: 0in">
            <p><code class=3D"western"><font size=3D"1"
                  style=3D"font-size: 8pt">-</font></code></p>
          </td>
          <td width=3D"136" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">fails</font></p>
          </td>
          <td width=3D"59" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">BAD</font></p>
          </td>
        </tr>
        <tr>
          <td width=3D"90" height=3D"10" style=3D"border: none; padding: 0=
in">
            <p><font size=3D"1" style=3D"font-size: 8pt">git</font></p>
          </td>
          <td width=3D"88" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt"><code
                  class=3D"western">Linux </code><code class=3D"western">5=
.15</code></font></p>
          </td>
          <td width=3D"94" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">none</font></p>
          </td>
          <td width=3D"150" style=3D"border: none; padding: 0in">
            <p><br>
            </p>
          </td>
          <td width=3D"136" style=3D"border: none; padding: 0in">
            <p><br>
            </p>
          </td>
          <td width=3D"59" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">not testable syst=
em
                freeze</font></p>
          </td>
        </tr>
        <tr>
          <td width=3D"90" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">git</font></p>
          </td>
          <td width=3D"88" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt"><code
                  class=3D"western">Linux </code><code class=3D"western">7=
.0.2</code></font></p>
          </td>
          <td width=3D"94" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">revert attempted<=
/font></p>
          </td>
          <td width=3D"150" style=3D"border: none; padding: 0in">
            <p><br>
            </p>
          </td>
          <td width=3D"136" style=3D"border: none; padding: 0in">
            <p><br>
            </p>
          </td>
          <td width=3D"59" style=3D"border: none; padding: 0in">
            <p><font size=3D"1" style=3D"font-size: 8pt">not testable</fon=
t></p>
          </td>
        </tr>
      </tbody>
    </table>
    <p><br>
    </p>
    <p>Kind regards,<br>
      Matthias<br>
      <br>
    </p>
    <div class=3D"moz-cite-prefix">Am 11.05.2026 um 11:34 schrieb Matthias
      Dittrich:<br>
    </div>
    <blockquote type=3D"cite"
      cite=3D"mid:561131dd-0e42-437a-9724-a036238a9bb4@gmx.net">
      <div class=3D"moz-text-html" lang=3D"x-unicode">
        <p class=3D"isSelectedEnd"><span>Dear Bjorn,</span></p>
        <p class=3D"isSelectedEnd"><span>Thank you for the quick response.
            For transparency, I used the AI tool Gemini during the
            bug-fixing and testing process. I am not an IT specialist
            and therefore cannot fully verify all of the AI=E2=80=99s
            conclusions in my last mail.</span></p>
        <p class=3D"isSelectedEnd"><span>All kernels were tested manually
            by installing the OS and kernel. The recommended boot
            parameters were also tested=C2=A0</span><span>manually</span><=
span>.
            The logs sent previously and in this mail are raw terminal
            outputs generated from the commands listed in the "Skript"
            file.</span></p>
        <p class=3D"isSelectedEnd"><br>
          <span>The=C2=A0</span><span style=3D"white-space: pre-wrap">dmes=
g and </span><code
            dir=3D"ltr"><span>lspci</span></code><span> output from the
            newest CachyOS kernel is attached.=C2=A0Additionally, the
            following commands were also run for the Ubuntu 5.15 kernel
            for comparison:</span></p>
        <p>dmesg<br>
          sudo lspci -vv &gt; lspci-vv-ubuntu2205-K515-good.txt<br>
          sudo lspci -vvv &gt; lspci-vvv-ubuntu2205-K515-good.txt<br>
          sudo lspci -vvxxxx &gt; lspci-vvxxxx-ubuntu2205-K515-good.txt<br=
>
          sudo lspci -s 02:00.0 -vvxxxx &gt; lspci_gpu_$(uname -r).txt<br>
          sudo lspci -t &gt; lspci_tree_$(uname -r).txt</p>
        <p><br>
        </p>
        <p><span>Gemini recommended performing a git bisect with
            optimized parameters to reduce compilation time.</span></p>
        <ul data-spread=3D"true">
          <li><span>Before starting the bisect tests, I tested different
              kernel revisions. The "git" kernel 5.15 (with
              localmodconfig) appears to work just like the newer Ubuntu
              5.15 kernel, as the graphics card status is shown as </span>=
<code
              dir=3D"ltr"><span>(rev a1)</span></code><span>. The
              earliest=C2=A0</span><span>kernel </span><span>revision wher=
e
              the status changes to </span><code dir=3D"ltr"><span>(rev
                ff)</span></code><span> starts with kernel 5.16 (tested
              with localmodconfig). However, the NVIDIA driver itself
              could not be tested.</span></li>
          <li><span>The bisect between 5.15 and 5.16 result in<code>=C2=A0=
[342a67f0884293639bd17ea44df754ead799e669]</code></span><code
              dir=3D"ltr"><span>=C2=A0NFS: Label the dentry with a verifie=
r in
                nfs_link(), nfs_symlink()</span></code><span>, which
              seems incorrect, as the verification using </span><code
              dir=3D"ltr"><span>git checkout
                342a67f0884293639bd17ea44df754ead799e669~1</span></code><s=
pan>
              also failed.</span></li>
          <li><span>An automated bisect was attempted without
              localmodconfig, but there were technical issues and I have
              not yet been able to complete the testing.</span></li>
        </ul>
        <p><span>I also noticed that the </span><code dir=3D"ltr"><span>ls=
pci</span></code><span>
            results differ between CachyOS and Ubuntu:</span></p>
        <p><span>02:00.0 3D controller: NVIDIA Corporation GP108M <span
              data-placeholder-token=3D"true"
              class=3D"text-token-text-primary cursor-text rounded-sm">[Ge=
Force
              MX250]</span> (rev a1)</span></p>
        <ul data-spread=3D"true">
          <li><code dir=3D"ltr"><span>(rev a1)</span></code><span> =E2=80=
=94
              Ubuntu 22.04 Kernel 5.15 (works), CachyOS Kernel 6.1 LTS
              and Kernel 7, but NVIDIA MX150 does not work</span></li>
          <li><code dir=3D"ltr"><span>(rev ff)</span></code><span> =E2=80=
=94
              Ubuntu 22.04 Kernel 5.16 and newer (localmodconfig) and
              Kernel 6.8 and=C2=A0</span><span>NVIDIA MX150 does not work<=
/span></li>
        </ul>
        <p><span>Kind regards,</span><br>
          <span>Matthias</span></p>
        <p><br>
        </p>
        <p><br>
        </p>
        <div class=3D"moz-cite-prefix">Am 01.05.2026 um 18:55 schrieb
          Bjorn Helgaas:<br>
        </div>
        <blockquote type=3D"cite"
          cite=3D"mid:20260501165542.GA491695@bhelgaas">
          <pre wrap=3D"" class=3D"moz-quote-pre">[+cc Ilpo]

On Fri, May 01, 2026 at 10:13:41AM +0200, Matthias Dittrich wrote:
</pre>
          <blockquote type=3D"cite">
            <pre wrap=3D"" class=3D"moz-quote-pre">Dear Kernel Developers,

I found a regression and did my best to identify the issue and find a
workaround, but I am not a developer. I also published the regression in t=
he
NVIDIA Linux Developer Forum, but it appears to be a kernel regression and
not a driver issue, as the latest drivers work on older kernels (e.g., 5.1=
5)
but fail on anything 6.x+. I did not perform a git bisect as compiling on
this i5-8265U - because of its low performance I can only compile one kern=
el
over night.

**Description:**
The NVIDIA MX250 GPU on Acer Swift 3 (SF314-56G / BIOS 1.14) is inaccessib=
le
on any Linux distribution using Kernel 6.x or 7.x. The device fails to
initialize during the driver probe routine.
</pre>
          </blockquote>
          <pre wrap=3D"" class=3D"moz-quote-pre">Thanks for the report.  W=
ith the newest kernel available to you, can
you please capture the complete dmesg and output of "sudo lspci -vv"?
Don't filter out things that don't seem relevant; we can easily do
that.

Bjorn
</pre>
        </blockquote>
      </div>
    </blockquote>
  </body>
</html>

--------------0GulcH7rlDymQw5xhJK1j89g--
--------------Gb6XiQ5ZQS0IfI3wtOfFmIoh
Content-Type: text/plain; charset=UTF-8; name="bisect.sh"
Content-Disposition: attachment; filename="bisect.sh"
Content-Transfer-Encoding: base64

IyEvdXNyL2Jpbi9lbnYgYmFzaAojIERhdGVpOiBhdXRvbWF0YXRpb24tYmlzZWN0LWNoYXRn
cHQuc2gKCnNldCAtZXVvIHBpcGVmYWlsCnNldCAteCAgICMgb3B0aW9uYWw6IERlYnVnIChr
YW5uc3QgZHUgc3DDpHRlciBhdXNrb21tZW50aWVyZW4pCgoKOiA8PCdLT01NRU5UQVInClVi
dW50dSDihpIg4oCeU3RhcnRwcm9ncmFtbWXigJwKbm9odXAgL2hvbWUvbHh1c2VyL2tlcm5l
bC1iaXNlY3QvYmlzZWN0LnNoID4gL2hvbWUvbHh1c2VyL2tlcm5lbC1iaXNlY3QvYmlzZWN0
LmxvZyAyPiYxICYKCiMgTWVpbiBTa3JpcHQKc3VkbyB2aXN1ZG8gL2V0Yy9zdWRvZXJzCmx4
dXNlciBBTEw9KEFMTCkgTk9QQVNTV0Q6IEFMTAoKRGFzIGtvbXBsZXR0ZSBTa3JpcHQKCm1r
ZGlyIC9ob21lL2x4dXNlci9rZXJuZWwtYmlzZWN0LwpjcCAvaG9tZS9seHVzZXIvYXV0b21h
dGlvbi1iaXNlY3QtY2hhdGdwdC5zaCAvaG9tZS9seHVzZXIva2VybmVsLWJpc2VjdC9iaXNl
Y3Quc2gKY2htb2QgK3ggL2hvbWUvbHh1c2VyL2tlcm5lbC1iaXNlY3QvYmlzZWN0LnNoCgpF
aW5tYWxpZyBpbnN0YWxsaWVyZW4Kc3VkbyBhcHQgdXBkYXRlCnN1ZG8gYXB0IGluc3RhbGwg
LXkgXAogICAgZ2l0IGJ1aWxkLWVzc2VudGlhbCBiYyBiaXNvbiBmbGV4IFwKICAgIGxpYnNz
bC1kZXYgbGliZWxmLWRldiBkd2FydmVzIFwKICAgIGxpYm5jdXJzZXMtZGV2IGNjYWNoZSBm
YWtlcm9vdCByc3luYwogICAgCmNjYWNoZSAtLW1heC1zaXplPTIwRwojdGVzdCBtaXQKY2Nh
Y2hlIC1zCgpLT01NRU5UQVIKCjogPDwnS09NTUVOVEFSJwojIEhpbndlaXMgQmlzZWN0IG11
c3MgZWlubWFsIGVyZm9sZ3JlaWNoIGdzdGFydGV0IHdlcmRlbiB1bmQgZGFubiBtYW51ZWxs
IGluIGRlbiBUZXN0a2VybmVsIGJvb3Rlbi4KIyBBbGxlIEtlcm5lbCBhdXMgdm9yaGVyaWdl
bSBUZXN0IGzDtnNjaGVuLgpzdWRvIHJtIC12IC9ib290Lyo1LjE1LjAtYnVpbGQqIC9ib290
Lyo1LjE1LjAtcmMqIC9ib290Lyo1LjE1LjArKiAvYm9vdC92bWxpbnV6LTUuMTUuMCAvYm9v
dC9pbml0cmQuaW1nLTUuMTUuMCAvYm9vdC9TeXN0ZW0ubWFwLTUuMTUuMCAvYm9vdC9jb25m
aWctNS4xNS4wCnN1ZG8gcm0gLXJmIC9saWIvbW9kdWxlcy81LjE1LjAtYnVpbGQqIC9saWIv
bW9kdWxlcy81LjE1LjAtcmMqIC9saWIvbW9kdWxlcy81LjE1LjArKiAvbGliL21vZHVsZXMv
NS4xNS4wCmxzIC9ib290L3ZtbGludXotNi44LjAtMTExLWdlbmVyaWMgL2Jvb3Qvdm1saW51
ei01LjE1Ljc1LXhhbm1vZDEgL2Jvb3Qvdm1saW51ei01LjE1LjAtMTc3LWdlbmVyaWMKc3Vk
byB1cGRhdGUtZ3J1YgoKIyBBdcOfZXJkZW0gbcO8c3NlbSBhbGxlIERhdGVpZW4gZWlubWFs
IGdlbMO2c2NodCB3ZXJkZW4Kc3VkbyBybSAtciAvaG9tZS9seHVzZXIva2VybmVsLWJpc2Vj
dC8KCktPTU1FTlRBUgoKaWYgW1sgIiQodW5hbWUgLXIpIiA9PSAiNi44LjAtMTExLWdlbmVy
aWMiIF1dOyB0aGVuCiAgICBlY2hvCiAgICBlY2hvICI9PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09IgogICAgZWNobyAiTUFOVUVMTEVSIEFCQlJV
Q0hLRVJORUwgRVJLQU5OVCIKICAgIGVjaG8gIkJJU0VDVCBXSVJEIEJFRU5ERVQiCiAgICBl
Y2hvICI9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
IgogICAgZWNobwoKICAgIGV4aXQgMApmaQoKIyA9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KIyBLT05GSUcKIyA9PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KCldPUktE
SVI9Ii9ob21lL2x4dXNlci9rZXJuZWwtYmlzZWN0IgpMSU5VWERJUj0iJFdPUktESVIvbGlu
dXgiCgpHT09EX1RBRz0idjUuMTUiCkJBRF9UQUc9InY1LjE2IgoKR09PRF9LRVJORUw9IjUu
MTUuMC0xNzctZ2VuZXJpYyIKCkpPQlM9OAoKQlVJTEROUl9GSUxFPSIkV09SS0RJUi9idWls
ZG5yLnR4dCIKQklTRUNUX1ZBUj0iJFdPUktESVIvYmlzZWN0LXZhcmlhYmxlLnR4dCIKQklT
RUNUX0xPRz0iJFdPUktESVIvYmlzZWN0LWluZm8udHh0IgoKbWtkaXIgLXAgIiRXT1JLRElS
IgoKIyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT0KIyBNQU5VRUxMRVIgU1RPUCAob3B0aW9uYWwgU2FmZXR5KQojID09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQoKaWYg
W1sgIiQodW5hbWUgLXIpIiA9PSAiNi44LjAtMTExLWdlbmVyaWMiIF1dOyB0aGVuCiAgICBl
Y2hvICJNQU5VRUxMRVIgQUJCUlVDSEtFUk5FTCBFUktBTk5UIgogICAgZXhpdCAwCmZpCgoj
ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PQojIEJVSUxEIEZVTktUSU9OCiMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09CgpidWlsZF9rZXJuZWwoKSB7CgogICAgY2Qg
IiRMSU5VWERJUiIKCiAgICAjIFNhZmV0eTogQnVpbGRuciBzaWNoZXJzdGVsbGVuCiAgICBb
WyAtZiAiJEJVSUxETlJfRklMRSIgXV0gfHwgZWNobyAxID4gIiRCVUlMRE5SX0ZJTEUiCiAg
ICBCVUlMRE5SPSQoY2F0ICIkQlVJTEROUl9GSUxFIikKCiAgICBlY2hvICI9PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09IgogICAgZWNobyAiQlVJ
TEQgYnVpbGQkQlVJTEROUiIKICAgIGVjaG8gIj09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT0iCgogICAgIyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogICAgIyBCQVNFIENPTkZJRyAoU1RB
QkxFKQogICAgIyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQoKICAgIGNwIC9ib290L2NvbmZpZy0kR09PRF9LRVJORUwgLmNvbmZpZwog
ICAgbWFrZSBvbGRkZWZjb25maWcKCiAgICAuL3NjcmlwdHMvY29uZmlnIC0tc2V0LXN0ciBM
T0NBTFZFUlNJT04gIi1idWlsZC0kQlVJTEROUiIKCiAgICAjIC0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAgICAjIFNBRkUgT1BUSU1J
WkFUSU9OIChOTyBQQ0kvQUNQSSBUT1VDSCkKICAgICMgLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KCiAgICAuL3NjcmlwdHMvY29uZmln
IC0tZGlzYWJsZSBERUJVR19JTkZPCiAgICAuL3NjcmlwdHMvY29uZmlnIC0tZGlzYWJsZSBE
RUJVR19JTkZPX0JURgogICAgLi9zY3JpcHRzL2NvbmZpZyAtLXNldC1zdHIgU1lTVEVNX1RS
VVNURURfS0VZUyAiIgogICAgLi9zY3JpcHRzL2NvbmZpZyAtLXNldC1zdHIgU1lTVEVNX1JF
Vk9DQVRJT05fS0VZUyAiIgoKICAgICMgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KICAgICMgQlVJTEQKICAgICMgLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KCiAgICBtYWtlIHBy
ZXBhcmUKICAgIGV4cG9ydCBLQ0ZMQUdTPSItTzIiCgogICAgbWFrZSAtaiIkSk9CUyIgYnpJ
bWFnZSBtb2R1bGVzCgogICAgIyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQogICAgIyBJTlNUQUxMCiAgICAjIC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCgogICAgc3VkbyBtYWtl
IG1vZHVsZXNfaW5zdGFsbAogICAgc3VkbyBtYWtlIGluc3RhbGwKCiAgICBLRVJORUxfUkVM
RUFTRT0kKG1ha2Uga2VybmVscmVsZWFzZSkKCiAgICBlY2hvICJLZXJuZWxyZWxlYXNlOiAk
S0VSTkVMX1JFTEVBU0UiCgogICAgc3VkbyB1cGRhdGUtaW5pdHJhbWZzIC1jIC1rICIkS0VS
TkVMX1JFTEVBU0UiCiAgICBzdWRvIHVwZGF0ZS1ncnViCgogICAgc3VkbyBncnViLXJlYm9v
dCBcCiAgICAgICAgIkFkdmFuY2VkIG9wdGlvbnMgZm9yIFVidW50dT5VYnVudHUsIHdpdGgg
TGludXggJEtFUk5FTF9SRUxFQVNFIgoKICAgIGVjaG8gIlJFQk9PVCAtPiAkS0VSTkVMX1JF
TEVBU0UiCiAgICBzdWRvIHJlYm9vdAp9CgojID09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQojIEVSU1RFUiBTVEFSVD8KIyA9PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0K
CmlmIFtbICEgLWQgIiRMSU5VWERJUi8uZ2l0IiBdXTsgdGhlbgoKICAgIGVjaG8KICAgIGVj
aG8gIj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0i
CiAgICBlY2hvICJJTklUSUFMSVNJRVJFIEJJU0VDVCIKICAgIGVjaG8gIj09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0iCiAgICBlY2hvCgogICAg
Y2QgIiRXT1JLRElSIgoKICAgICMgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0KICAgICMgS2VybmVscmVwbyBlZmZpemllbnQga2xvbmVu
CiAgICAjIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tCgogICAgZ2l0IGNsb25lIFwKICAgICAgICAtLWJyYW5jaCB2NS4xNiBcCiAgICAg
ICAgLS1zaW5nbGUtYnJhbmNoIFwKICAgICAgICBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1
Yi9zY20vbGludXgva2VybmVsL2dpdC9zdGFibGUvbGludXguZ2l0IFwKICAgICAgICBsaW51
eAoKICAgIGNkICIkTElOVVhESVIiCgogICAgIyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogICAgIyBCaXNlY3QgaW5pdGlhbGlzaWVy
ZW4KICAgICMgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0KCiAgICBnaXQgYmlzZWN0IHN0YXJ0CgogICAgZ2l0IGJpc2VjdCBiYWQgIiRC
QURfVEFHIgoKICAgIGdpdCBiaXNlY3QgZ29vZCAiJEdPT0RfVEFHIgoKICAgICMgLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KICAgICMg
QnVpbGRudW1tZXIgaW5pdGlhbGlzaWVyZW4KICAgICMgLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KCiAgICBlY2hvIDEgPiAiJEJVSUxE
TlJfRklMRSIKCiAgICAjIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tCiAgICAjIEVyc3RlbiBLZXJuZWwgYmF1ZW4KICAgICMgLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KCiAgICBi
dWlsZF9rZXJuZWwKCiAgICBleGl0IDAKZmkKCiMgPT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiMgQ1VSUkVOVCBLRVJORUwgQ0hF
Q0sKIyA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT0KCkNVUlJFTlRfS0VSTkVMPSQodW5hbWUgLXIpCgplY2hvICI9PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09IgplY2hvICJDVVJSRU5U
OiAkQ1VSUkVOVF9LRVJORUwiCmVjaG8gIj09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT0iCgojID09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PQojIFRFU1RLRVJORUwgTU9ERQojID09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQoK
aWYgW1sgIiRDVVJSRU5UX0tFUk5FTCIgIT0gIiRHT09EX0tFUk5FTCIgXV07IHRoZW4KCiAg
ICBlY2hvICJURVNUS0VSTkVMIE1PREUiCgogICAgewogICAgICAgIGVjaG8gIj09PT09PT09
PT09PT09PT09PT09IgogICAgICAgIGRhdGUKICAgICAgICB1bmFtZSAtcgogICAgICAgIGxz
cGNpIC1rIHwgZ3JlcCAtQSAyIC1FICIoVkdBfDNEKSIKICAgIH0gPj4gIiRCSVNFQ1RfTE9H
IgoKICAgICMgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0KICAgICMgUENJIENIRUNLIChST0JVU1QgKyBGQUxMQkFDSykKICAgICMgLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KCiAg
ICBpZiBsc3BjaSAtbiAtcyAwMjowMC4wID4vZGV2L251bGwgMj4mMTsgdGhlbgogICAgICAg
IGxzcGNpIC1uIC1zIDAyOjAwLjAgXAogICAgICAgICAgICB8IGdyZXAgLW8gInJldiBbYS1m
MC05XVx7Mlx9IiBcCiAgICAgICAgICAgID4gIiRCSVNFQ1RfVkFSIiB8fCB0cnVlCiAgICBl
bHNlCiAgICAgICAgZWNobyAicmV2IGZmIiA+ICIkQklTRUNUX1ZBUiIKICAgIGZpCgogICAg
Y2F0ICIkQklTRUNUX1ZBUiIKCiAgICAjIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAgICAjIEJBQ0sgVE8gU1RBQkxFIEtFUk5FTAog
ICAgIyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQoKICAgIHN1ZG8gZ3J1Yi1yZWJvb3QgXAogICAgICAgICJBZHZhbmNlZCBvcHRpb25z
IGZvciBVYnVudHU+VWJ1bnR1LCB3aXRoIExpbnV4ICRHT09EX0tFUk5FTCIKCiAgICBzdWRv
IHJlYm9vdAogICAgZXhpdCAwCmZpCgojID09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PQojIEhPU1QgTU9ERSAoQklTRUNUIENPTlRS
T0wpCiMgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09CgplY2hvICJIT1NUIE1PREUiCgpjZCAiJExJTlVYRElSIgoKW1sgLWYgIiRC
SVNFQ1RfVkFSIiBdXSB8fCB7CiAgICBlY2hvICJCSVNFQ1QgVkFSSUFCTEUgRkVITFQiCiAg
ICBleGl0IDEKfQoKUkVTVUxUPSQoY2F0ICIkQklTRUNUX1ZBUiIpCgplY2hvICJSRVNVTFQ6
ICRSRVNVTFQiCgojIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQojIEdPT0QgLyBCQUQgQ0xBU1NJRklDQVRJT04KIyAtLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KCmlm
IGdyZXAgLXEgInJldiBhMSIgIiRCSVNFQ1RfVkFSIjsgdGhlbgoKICAgIGVjaG8gIj09PiBH
T09EIgogICAgZ2l0IGJpc2VjdCBnb29kCgplbGlmIGdyZXAgLXEgInJldiBmZiIgIiRCSVNF
Q1RfVkFSIjsgdGhlbgoKICAgIGVjaG8gIj09PiBCQUQiCiAgICBnaXQgYmlzZWN0IGJhZAoK
ZWxzZQogICAgZWNobyAiVU5LTk9XTiIKICAgIGNhdCAiJEJJU0VDVF9WQVIiCiAgICBleGl0
IDEKZmkKCiMgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tCiMgRU5EIENIRUNLCiMgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCgppZiBnaXQgYmlzZWN0IGxvZyB8IHRh
aWwgLW4gMSB8IGdyZXAgLXEgImZpcnN0IGJhZCBjb21taXQiOyB0aGVuCiAgICBlY2hvICJC
SVNFQ1QgQ09NUExFVEUiCiAgICBnaXQgYmlzZWN0IGxvZyA+ICIkV09SS0RJUi9maW5hbC1i
aXNlY3QtbG9nLnR4dCIKICAgIGdpdCBiaXNlY3QgcmVzZXQKICAgIGV4aXQgMApmaQoKIyAt
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0KIyBORVhUIEJVSUxEIE5VTUJFUgojIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQoKQlVJTEROUj0kKGNhdCAiJEJVSUxETlJf
RklMRSIpCkJVSUxETlI9JCgoQlVJTEROUiArIDEpKQplY2hvICIkQlVJTEROUiIgPiAiJEJV
SUxETlJfRklMRSIKCmJ1aWxkX2tlcm5lbAo=
--------------Gb6XiQ5ZQS0IfI3wtOfFmIoh
Content-Type: text/plain; charset=UTF-8; name="final-bisect-log.txt"
Content-Disposition: attachment; filename="final-bisect-log.txt"
Content-Transfer-Encoding: base64

Z2l0IGJpc2VjdCBzdGFydAojIGJhZDogW2RmMGNjNTdlMDU3ZjE4ZTQ0ZGFjOGU2YzE4YWJh
NDdhYjUzMjAyZjldIExpbnV4IDUuMTYKZ2l0IGJpc2VjdCBiYWQgZGYwY2M1N2UwNTdmMThl
NDRkYWM4ZTZjMThhYmE0N2FiNTMyMDJmOQojIGdvb2Q6IFs4YmI3ZWNhOTcyYWQ1MzFjOWIx
NDljMGE1MWFiNDNhNDE3Mzg1ODEzXSBMaW51eCA1LjE1CmdpdCBiaXNlY3QgZ29vZCA4YmI3
ZWNhOTcyYWQ1MzFjOWIxNDljMGE1MWFiNDNhNDE3Mzg1ODEzCiMgYmFkOiBbMjIxOWIwY2Vl
ZmU4MzViOTJhOGE3NGE3M2ZlOTY0YWEwNTI3NDJhMl0gTWVyZ2UgdGFnICdzb2MtNS4xNicg
b2YgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3NvYy9z
b2MKZ2l0IGJpc2VjdCBiYWQgMjIxOWIwY2VlZmU4MzViOTJhOGE3NGE3M2ZlOTY0YWEwNTI3
NDJhMgojIGdvb2Q6IFtmYzAyY2IyYjM3ZmUyY2JmMWQzMzM0YjlmMGYwZWFiOTQzMTc2NmM0
XSBNZXJnZSB0YWcgJ25ldC1uZXh0LWZvci01LjE2JyBvZiBnaXQ6Ly9naXQua2VybmVsLm9y
Zy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbmV0ZGV2L25ldC1uZXh0CmdpdCBiaXNlY3Qg
Z29vZCBmYzAyY2IyYjM3ZmUyY2JmMWQzMzM0YjlmMGYwZWFiOTQzMTc2NmM0CiMgZ29vZDog
W2Q5YmQwNTQxNzdmYmQyYzQ3NjI1NDZhZWM0MGZjMzA3MWJmZTRjYzBdIE1lcmdlIHRhZyAn
YW1kLWRybS1uZXh0LTUuMTYtMjAyMS0xMC0yOScgb2YgaHR0cHM6Ly9naXRsYWIuZnJlZWRl
c2t0b3Aub3JnL2FnZDVmL2xpbnV4IGludG8gZHJtLW5leHQKZ2l0IGJpc2VjdCBnb29kIGQ5
YmQwNTQxNzdmYmQyYzQ3NjI1NDZhZWM0MGZjMzA3MWJmZTRjYzAKIyBiYWQ6IFtkY2Q2ODMy
NmQyOWI2MmYzMDM5ZTRmNGQyM2QzZTM4ZjI0ZDM3MzYwXSBNZXJnZSB0YWcgJ2RldmljZXRy
ZWUtZm9yLTUuMTYnIG9mIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2Vy
bmVsL2dpdC9yb2JoL2xpbnV4CmdpdCBiaXNlY3QgYmFkIGRjZDY4MzI2ZDI5YjYyZjMwMzll
NGY0ZDIzZDNlMzhmMjRkMzczNjAKIyBnb29kOiBbYmJhN2Q2ODIyNzdjMDkzNzNiNTZiMDQ2
MWIwYWJiZDBiM2QxZTg3Ml0gTWVyZ2UgdGFnICd4ZnMtNS4xNi1tZXJnZS00JyBvZiBnaXQ6
Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2ZzL3hmcy94ZnMtbGludXgKZ2l0IGJpc2VjdCBn
b29kIGJiYTdkNjgyMjc3YzA5MzczYjU2YjA0NjFiMGFiYmQwYjNkMWU4NzIKIyBiYWQ6IFs2
YWIxZDQ4MzlhNDg2NzI3ZmRkNDEyYmQ4YmFiMjc0MTczODhkMzgxXSBNZXJnZSB0YWcgJ3Bs
YXRmb3JtLWRyaXZlcnMteDg2LXY1LjE2LTEnIG9mIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1
Yi9zY20vbGludXgva2VybmVsL2dpdC9wZHg4Ni9wbGF0Zm9ybS1kcml2ZXJzLXg4NgpnaXQg
YmlzZWN0IGJhZCA2YWIxZDQ4MzlhNDg2NzI3ZmRkNDEyYmQ4YmFiMjc0MTczODhkMzgxCiMg
YmFkOiBbODMzZGI3MjE0MmI5M2E4OTIxMWMxZTQzY2EwYTFlMmUxNjQ1Nzc1Nl0gTWVyZ2Ug
dGFnICdwbS01LjE2LXJjMScgb2YgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51
eC9rZXJuZWwvZ2l0L3JhZmFlbC9saW51eC1wbQpnaXQgYmlzZWN0IGJhZCA4MzNkYjcyMTQy
YjkzYTg5MjExYzFlNDNjYTBhMWUyZTE2NDU3NzU2CiMgZ29vZDogW2JmNTZiOTA3OTdjNGEw
M2M5NGI3MDJjNTBlNjIyOTZlZGVhOWZhZDldIE1lcmdlIGJyYW5jaGVzICdwbS1lbScgYW5k
ICdwb3dlcmNhcCcKZ2l0IGJpc2VjdCBnb29kIGJmNTZiOTA3OTdjNGEwM2M5NGI3MDJjNTBl
NjIyOTZlZGVhOWZhZDkKIyBiYWQ6IFtmOGRmMTYwMTZkMmQ4M2Q0OTZmMWZmYTQyZjhkODZl
ZDdjZDhkYjQ3XSBNZXJnZSBicmFuY2hlcyAnYWNwaS1wbScsICdhY3BpLWJhdHRlcnknIGFu
ZCAnYWNwaS1hYycKZ2l0IGJpc2VjdCBiYWQgZjhkZjE2MDE2ZDJkODNkNDk2ZjFmZmE0MmY4
ZDg2ZWQ3Y2Q4ZGI0NwojIGdvb2Q6IFtiMmZmYTE2YTFjODM3ZTUwYTI5ZDQzZmU5MzA5MTQ5
MjY5MzY0OGZlXSBNZXJnZSBicmFuY2hlcyAnYWNwaS14ODYnLCAnYWNwaS1yZXNvdXJjZXMn
LCAnYWNwaS1zY2FuJyBhbmQgJ2FjcGktbWlzYycKZ2l0IGJpc2VjdCBnb29kIGIyZmZhMTZh
MWM4MzdlNTBhMjlkNDNmZTkzMDkxNDkyNjkzNjQ4ZmUKIyBnb29kOiBbYzNmYjQ2NjAwZTNm
MTdlZTI0YzhkODY0ODJmYWI1MTBmZDVmODc3MV0gTWVyZ2UgYnJhbmNoZXMgJ2FjcGktZ2x1
ZScsICdhY3BpLXBucCcsICdhY3BpLXByb2Nlc3NvcicgYW5kICdhY3BpLXNvYycKZ2l0IGJp
c2VjdCBnb29kIGMzZmI0NjYwMGUzZjE3ZWUyNGM4ZDg2NDgyZmFiNTEwZmQ1Zjg3NzEKIyBi
YWQ6IFthOWE4ZjgyN2Y5ZTgxZGM4NTA2ZDMyODNkMTY2Y2Q2ZWZlODIyMzAyXSBBQ1BJOiBQ
TTogVHVybiBvZmYgd2FrZXVwIHBvd2VyIHJlc291cmNlcyBvbiBfRFNXL19QU1cgZXJyb3Jz
CmdpdCBiaXNlY3QgYmFkIGE5YThmODI3ZjllODFkYzg1MDZkMzI4M2QxNjZjZDZlZmU4MjIz
MDIKIyBiYWQ6IFs3YTYzMjk2ZDZmNTc5YTAyYjI2NzViNGIwZmU1YjFjZDMyMzVlOGQzXSBB
Q1BJOiBQTTogVHVybiBvZmYgdW51c2VkIHdha2V1cCBwb3dlciByZXNvdXJjZXMKZ2l0IGJp
c2VjdCBiYWQgN2E2MzI5NmQ2ZjU3OWEwMmIyNjc1YjRiMGZlNWIxY2QzMjM1ZThkMwojIGJh
ZDogW2ExMjI0ZjM0ZDcyYTEwMzgyOWQ2OTUzOTM1ZDZjNjYyMWYxMzViODNdIEFDUEk6IFBN
OiBDaGVjayBzdGF0ZXMgb2YgcG93ZXIgcmVzb3VyY2VzIGR1cmluZyBpbml0aWFsaXphdGlv
bgpnaXQgYmlzZWN0IGJhZCBhMTIyNGYzNGQ3MmExMDM4MjlkNjk1MzkzNWQ2YzY2MjFmMTM1
YjgzCiMgZmlyc3QgYmFkIGNvbW1pdDogW2ExMjI0ZjM0ZDcyYTEwMzgyOWQ2OTUzOTM1ZDZj
NjYyMWYxMzViODNdIEFDUEk6IFBNOiBDaGVjayBzdGF0ZXMgb2YgcG93ZXIgcmVzb3VyY2Vz
IGR1cmluZyBpbml0aWFsaXphdGlvbgo=
--------------Gb6XiQ5ZQS0IfI3wtOfFmIoh
Content-Type: text/plain; charset=UTF-8; name="Abschlusstest.txt"
Content-Disposition: attachment; filename="Abschlusstest.txt"
Content-Transfer-Encoding: base64

IyEvdXNyL2Jpbi9lbnYgYmFzaAojIEdlZ2VudGVzdCAtIEFic2Noa3Vzc3Rlc3QKCiMgc2V0
IC1ldW8gcGlwZWZhaWwKc2V0IC14ICAgIyBvcHRpb25hbDogRGVidWcgKGthbm5zdCBkdSBz
cMOkdGVyIGF1c2tvbW1lbnRpZXJlbikKCgo6IDw8J0tPTU1FTlRBUicKIyAtLS0tIFRlc3Qg
MSBnb29kIHp1c3RhbmQgdm9yIGRlbSBlcnN0ZW4gYmFkIGNvbW1lbnQtLS0tCmdpdCBjaGVj
a291dCBhMTIyNGYzNGQ3MmExMDM4MjlkNjk1MzkzNWQ2YzY2MjFmMTM1YjgzfjEKICAgIGNw
IC9ib290L2NvbmZpZy01LjE1LjAtMTc3LWdlbmVyaWMgLmNvbmZpZwogICAgbWFrZSBvbGRk
ZWZjb25maWcKICAgIC4vc2NyaXB0cy9jb25maWcgLS1zZXQtc3RyIExPQ0FMVkVSU0lPTiAi
LUFic2NobHVzc3Rlc3QiCiAgICAuL3NjcmlwdHMvY29uZmlnIC0tZGlzYWJsZSBERUJVR19J
TkZPCiAgICAuL3NjcmlwdHMvY29uZmlnIC0tZGlzYWJsZSBERUJVR19JTkZPX0JURgogICAg
Li9zY3JpcHRzL2NvbmZpZyAtLXNldC1zdHIgU1lTVEVNX1RSVVNURURfS0VZUyAiIgogICAg
Li9zY3JpcHRzL2NvbmZpZyAtLXNldC1zdHIgU1lTVEVNX1JFVk9DQVRJT05fS0VZUyAiIgog
ICAgbWFrZSBwcmVwYXJlCgogICMgV2ljaHRpZyBmw7xyIE52aWRpYSBUcmVpYmVyCiAgICBt
YWtlIG1vZHVsZXNfcHJlcGFyZSAgCgogICAgZXhwb3J0IEtDRkxBR1M9Ii1PMiIKICAgIG1h
a2UgLWo4IGJ6SW1hZ2UgbW9kdWxlcwogICAgc3VkbyBtYWtlIG1vZHVsZXNfaW5zdGFsbAog
ICAgc3VkbyBtYWtlIGluc3RhbGwKICAgIEtFUk5FTF9SRUxFQVNFPSQobWFrZSBrZXJuZWxy
ZWxlYXNlKQogICAgZWNobyAiS2VybmVscmVsZWFzZTogJEtFUk5FTF9SRUxFQVNFIgogICAg
c3VkbyB1cGRhdGUtaW5pdHJhbWZzIC1jIC1rICIkS0VSTkVMX1JFTEVBU0UiCiAgICBzdWRv
IHVwZGF0ZS1ncnViCgojIHJlYm9vdAojIGxzcGNpIC1rIHwgZ3JlcCAtQSAyIC1FICIoVkdB
fDNEKSIKIyBzdWRvIGRrbXMgYXV0b2luc3RhbGwgLWsgJCh1bmFtZSAtcikKIyBzdWRvIGRr
bXMgaW5zdGFsbCAtbSBudmlkaWEgLXYgNTgwLjE0MiAtayAkKHVuYW1lIC1yKQojIHN1ZG8g
dXBkYXRlLWluaXRyYW1mcyAtdSAtayAkKHVuYW1lIC1yKQojIHJlYm9vdCB1bmQgdGVzdCAK
IyBudmlkaWEtc21pCgojIC0tT0sgcmV2IGExIG9rIHVuZCBudmlkaWEgc21pIG9rCgoKCiMg
LS0tLSBSZXZlcnQtVGVzdCBhdWYgNS4xNiBLb250ZXh0IC0tLS0KCmdpdCBjaGVja291dCBh
MTIyNGYzNGQ3MmExMDM4MjlkNjk1MzkzNWQ2YzY2MjFmMTM1YjgzCmdpdCByZXZlcnQgLS1u
by1jb21taXQgYTEyMjRmMzRkNzJhMTAzODI5ZDY5NTM5MzVkNmM2NjIxZjEzNWI4MwoKY3Ag
L2Jvb3QvY29uZmlnLTUuMTUuMC0xNzctZ2VuZXJpYyAuY29uZmlnCm1ha2Ugb2xkZGVmY29u
ZmlnCgouL3NjcmlwdHMvY29uZmlnIC0tc2V0LXN0ciBMT0NBTFZFUlNJT04gIi1SZXZlcnQt
VGVzdCIKLi9zY3JpcHRzL2NvbmZpZyAtLWRpc2FibGUgREVCVUdfSU5GTwouL3NjcmlwdHMv
Y29uZmlnIC0tZGlzYWJsZSBERUJVR19JTkZPX0JURgouL3NjcmlwdHMvY29uZmlnIC0tc2V0
LXN0ciBTWVNURU1fVFJVU1RFRF9LRVlTICIiCi4vc2NyaXB0cy9jb25maWcgLS1zZXQtc3Ry
IFNZU1RFTV9SRVZPQ0FUSU9OX0tFWVMgIiIKCm1ha2UgcHJlcGFyZQptYWtlIG1vZHVsZXNf
cHJlcGFyZQoKZXhwb3J0IEtDRkxBR1M9Ii1PMiIKCm1ha2UgLWokKG5wcm9jKSBiekltYWdl
IG1vZHVsZXMKCnN1ZG8gbWFrZSBtb2R1bGVzX2luc3RhbGwKc3VkbyBtYWtlIGluc3RhbGwK
CktFUk5FTF9SRUxFQVNFPSQobWFrZSBrZXJuZWxyZWxlYXNlKQplY2hvICJLZXJuZWxyZWxl
YXNlOiAkS0VSTkVMX1JFTEVBU0UiCgpzdWRvIHVwZGF0ZS1pbml0cmFtZnMgLWMgLWsgIiRL
RVJORUxfUkVMRUFTRSIKc3VkbyB1cGRhdGUtZ3J1YgoKIyAtLU9LIHJldiBhMSBvayB1bmQg
bnZpZGlhIHNtaSBvawojIHRlc3QgbXVzcyB3aWVkZXJob2x0IHdlcmRlbgojIGRyaXZlciBi
cm9rZW4KCiNka21zIHN0YXR1cwojbHMgLWwgL2xpYi9tb2R1bGVzLyQodW5hbWUgLXIpL2J1
aWxkCiNscyAtbGggL2hvbWUvbHh1c2VyL2tlcm5lbC1iaXNlY3QvbGludXgvTW9kdWxlLnN5
bXZlcnMKI2ZpbmQgL3Zhci9saWIvZGttcy9udmlkaWEgLW1heGRlcHRoIDMgLXR5cGUgZAoj
c3VkbyBka21zIHJlbW92ZSBudmlkaWEvNTgwLjE0MiAtLWFsbAojc3VkbyBybSAtcmYgL3Zh
ci9saWIvZGttcy9udmlkaWEKI3N1ZG8gZmluZCAvbGliL21vZHVsZXMgLWluYW1lICJudmlk
aWEqLmtvKiIgLWRlbGV0ZQojc3VkbyBkZXBtb2QgLWEKI3N1ZG8gbW9kcHJvYmUgbnZpZGlh
CiNzdWRvIGRrbXMgaW5zdGFsbCAtLWZvcmNlIC1tIG52aWRpYSAtdiA1ODAuMTQyIC1rICQo
dW5hbWUgLXIpCiNmaW5kIC9saWIvbW9kdWxlcy8kKHVuYW1lIC1yKSAtaW5hbWUgIm52aWRp
YSoua28qIgojc3VkbyBkZXBtb2QgLWEKI3N1ZG8gbW9kcHJvYmUgbnZpZGlhCiMgc3VkbyB1
cGRhdGUtaW5pdHJhbWZzIC11IC1rICQodW5hbWUgLXIpCgojIC0tLSB0ZXN0IG9rIC0tLSBu
dmlkaWEgd29yawoKS09NTUVOVEFSCgojID09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PQojIDYuMSBSRVZFUlQgVEVTVCAobW9kZXJu
IGJhc2VsaW5lICsgY3VycmVudCBjb25maWcpCiMgPT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CgpXT1JLRElSPSQocHdkKQoKI2Vj
aG8gIj09PiBDbGVhbiB0cmVlIgojZ2l0IHJlc2V0IC0taGFyZAojZ2l0IGNsZWFuIC1mZHgK
CmVjaG8gIj09PiBDaGVja291dCBMaW51eCA2LjEiCmdpdCBjaGVja291dCB2Ni4xCgplY2hv
ICI9PT4gQXBwbHkgQUNQSSByZWdyZXNzaW9uIHJldmVydCB0ZXN0IgpnaXQgcmV2ZXJ0IC0t
bm8tY29tbWl0IGExMjI0ZjM0ZDcyYTEwMzgyOWQ2OTUzOTM1ZDZjNjYyMWYxMzViODMgfHwg
ewogICAgZWNobyAiUkVWRVJUIEZBSUxFRCAoY29uZmxpY3QpIgogICAgZ2l0IHJldmVydCAt
LWFib3J0CiAgICBleGl0IDEKfQoKZWNobyAiPT0+IFVzZSBDVVJSRU5UIHJ1bm5pbmcga2Vy
bmVsIGNvbmZpZyIKY3AgL2Jvb3QvY29uZmlnLSQodW5hbWUgLXIpIC5jb25maWcKbWFrZSBv
bGRkZWZjb25maWcKCmVjaG8gIj09PiBMb2NhbCB2ZXJzaW9uIHRhZyIKLi9zY3JpcHRzL2Nv
bmZpZyAtLXNldC1zdHIgTE9DQUxWRVJTSU9OICItNi4xLVJldmVydC1UZXN0IgoKZWNobyAi
PT0+IERpc2FibGUgZGVidWcgb3ZlcmhlYWQiCi4vc2NyaXB0cy9jb25maWcgLS1kaXNhYmxl
IERFQlVHX0lORk8KLi9zY3JpcHRzL2NvbmZpZyAtLWRpc2FibGUgREVCVUdfSU5GT19CVEYK
Li9zY3JpcHRzL2NvbmZpZyAtLXNldC1zdHIgU1lTVEVNX1RSVVNURURfS0VZUyAiIgouL3Nj
cmlwdHMvY29uZmlnIC0tc2V0LXN0ciBTWVNURU1fUkVWT0NBVElPTl9LRVlTICIiCgplY2hv
ICI9PT4gUHJlcGFyZSBidWlsZCIKbWFrZSBwcmVwYXJlCm1ha2UgbW9kdWxlc19wcmVwYXJl
CgpleHBvcnQgS0NGTEFHUz0iLU8yIgoKZWNobyAiPT0+IEJ1aWxkIGtlcm5lbCIKbWFrZSAt
aiIkKG5wcm9jKSIgYnpJbWFnZSBtb2R1bGVzCgplY2hvICI9PT4gSW5zdGFsbCBrZXJuZWwi
CnN1ZG8gbWFrZSBtb2R1bGVzX2luc3RhbGwKc3VkbyBtYWtlIGluc3RhbGwKCktFUk5FTF9S
RUxFQVNFPSQobWFrZSBrZXJuZWxyZWxlYXNlKQplY2hvICJLZXJuZWxyZWxlYXNlOiAkS0VS
TkVMX1JFTEVBU0UiCgplY2hvICI9PT4gSW5pdHJhbWZzICsgR1JVQiIKc3VkbyB1cGRhdGUt
aW5pdHJhbWZzIC1jIC1rICIkS0VSTkVMX1JFTEVBU0UiCnN1ZG8gdXBkYXRlLWdydWIKCmVj
aG8gIj09PiBET05FIC0gcmVib290IHJlcXVpcmVkIgoKI2dvb2QgcmV2IGExICsgbnZpZGlh
IHdvcmsgYWZ0ZXIgcmVtb3ZlIGFuZCBpbnN0YWxsIGFnYWluIGxpa2UgUmV2ZXJ0LVRlc3Qg
YXVmIDUuMTYKCgo6IDw8J0tPTU1FTlRBUicKIyA9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KIyA3LjAgUkVWRVJUIFRFU1QgKG1v
ZGVybiBiYXNlbGluZSArIGN1cnJlbnQgY29uZmlnKQojID09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQoKV09SS0RJUj0kKHB3ZCkK
CiNlY2hvICI9PT4gQ2xlYW4gdHJlZSIKI2dpdCByZXNldCAtLWhhcmQKI2dpdCBjbGVhbiAt
ZmR4CgplY2hvICI9PT4gQ2hlY2tvdXQgTGludXggNyIKZ2l0IGNoZWNrb3V0IHY3CgplY2hv
ICI9PT4gQXBwbHkgQUNQSSByZWdyZXNzaW9uIHJldmVydCB0ZXN0IgpnaXQgcmV2ZXJ0IC0t
bm8tY29tbWl0IGExMjI0ZjM0ZDcyYTEwMzgyOWQ2OTUzOTM1ZDZjNjYyMWYxMzViODMgfHwg
ewogICAgZWNobyAiUkVWRVJUIEZBSUxFRCAoY29uZmxpY3QpIgogICAgZ2l0IHJldmVydCAt
LWFib3J0CiAgICBleGl0IDEKfQoKZWNobyAiPT0+IFVzZSBDVVJSRU5UIHJ1bm5pbmcga2Vy
bmVsIGNvbmZpZyIKY3AgL2Jvb3QvY29uZmlnLSQodW5hbWUgLXIpIC5jb25maWcKbWFrZSBv
bGRkZWZjb25maWcKCmVjaG8gIj09PiBMb2NhbCB2ZXJzaW9uIHRhZyIKLi9zY3JpcHRzL2Nv
bmZpZyAtLXNldC1zdHIgTE9DQUxWRVJTSU9OICItNy1SZXZlcnQtVGVzdCIKCmVjaG8gIj09
PiBEaXNhYmxlIGRlYnVnIG92ZXJoZWFkIgouL3NjcmlwdHMvY29uZmlnIC0tZGlzYWJsZSBE
RUJVR19JTkZPCi4vc2NyaXB0cy9jb25maWcgLS1kaXNhYmxlIERFQlVHX0lORk9fQlRGCi4v
c2NyaXB0cy9jb25maWcgLS1zZXQtc3RyIFNZU1RFTV9UUlVTVEVEX0tFWVMgIiIKLi9zY3Jp
cHRzL2NvbmZpZyAtLXNldC1zdHIgU1lTVEVNX1JFVk9DQVRJT05fS0VZUyAiIgoKZWNobyAi
PT0+IFByZXBhcmUgYnVpbGQiCm1ha2UgcHJlcGFyZQptYWtlIG1vZHVsZXNfcHJlcGFyZQoK
ZXhwb3J0IEtDRkxBR1M9Ii1PMiIKCmVjaG8gIj09PiBCdWlsZCBrZXJuZWwiCm1ha2UgLWoi
JChucHJvYykiIGJ6SW1hZ2UgbW9kdWxlcwoKZWNobyAiPT0+IEluc3RhbGwga2VybmVsIgpz
dWRvIG1ha2UgbW9kdWxlc19pbnN0YWxsCnN1ZG8gbWFrZSBpbnN0YWxsCgpLRVJORUxfUkVM
RUFTRT0kKG1ha2Uga2VybmVscmVsZWFzZSkKZWNobyAiS2VybmVscmVsZWFzZTogJEtFUk5F
TF9SRUxFQVNFIgoKZWNobyAiPT0+IEluaXRyYW1mcyArIEdSVUIiCnN1ZG8gdXBkYXRlLWlu
aXRyYW1mcyAtYyAtayAiJEtFUk5FTF9SRUxFQVNFIgpzdWRvIHVwZGF0ZS1ncnViCgplY2hv
ICI9PT4gRE9ORSAtIHJlYm9vdCByZXF1aXJlZCIKCiNnaXQgcmV2ZXJ0IC0tbm8tY29tbWl0
IGExMjI0ZjM0ZDcyYTEwMzgyOWQ2OTUzOTM1ZDZjNjYyMWYxMzViODMKYXV0b21hdGlzY2hl
ciBNZXJnZSB2b24gZHJpdmVycy9hY3BpL3Bvd2VyLmMKS09ORkxJS1QgKEluaGFsdCk6IE1l
cmdlLUtvbmZsaWt0IGluIGRyaXZlcnMvYWNwaS9wb3dlci5jCmVycm9yOiBLb25udGUgInJl
dmVydCIgbmljaHQgYXVmIGExMjI0ZjM0ZDcyYS4uLiAoQUNQSTogUE06IENoZWNrIHN0YXRl
cyBvZiBwb3dlciByZXNvdXJjZXMgZHVyaW5nIGluaXRpYWxpemF0aW9uKSBhdXNmw7xocmVu
CkhpbndlaXM6IG5hY2ggQXVmbMO2c3VuZyBkZXIgS29uZmxpa3RlIG1hcmtpZXJlbiBTaWUg
ZGllIGtvcnJpZ2llcnRlbiBQZmFkZQpIaW53ZWlzOiBtaXQgJ2dpdCBhZGQgPFBmYWRlPicg
b2RlciAnZ2l0IHJtIDxQZmFkZT4nCktPTU1FTlRBUgoKCg==

--------------Gb6XiQ5ZQS0IfI3wtOfFmIoh--
