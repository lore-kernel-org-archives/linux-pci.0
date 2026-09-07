Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDA23B71D9
	for <linux-pci@vger.kernel.org>; Mon,  7 Sep 2026 11:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788779485; cv=none; b=EFLV3q+RlfP3drprlaEoQNuWL/l0EQjursOJPfwRc8G5SnkOe17erLJp2YWZ2y0r7p0YD3bAwf28h1GTvhBqI37AAgf2W2EAL35XdZa1x42+E1juFHPbvgeE429KKvt9y1nGdQy17ryWgpRfQukpylEJBR/a7fvvfB20fNcM234=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788779485; c=relaxed/simple;
	bh=zmQm2sO1F3gb7uurfDOrEK2vXvZLG7pNbKR0c07iHlY=;
	h=Content-Type:Message-ID:Date:MIME-Version:From:Subject:To:Cc:
	 References:In-Reply-To; b=RiM6141NGxNUzEQjACPXKa35Z6Nf2xxO0Bgitpb38zjaKGDZXS1LS5T7+zpAfwZXBAScX+MezzVrSt+2Xic0NFnDEA+nZvJu6glGOWaCvh4TeExYQg0+ogIilRb/yZYdJ0Rj0yUjnHEguo0FP05XcpzTlJrGcewgg/hptE0oEls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=dittrich.m@gmx.net header.b=lmsgdvLp; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=dittrich.m@gmx.net header.b="lmsgdvLp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1788779462; x=1789384262; i=dittrich.m@gmx.net;
	bh=pOTICJK5uPYm6JJ2HOkz/bcwkl3zeN52G/uj89k13Nc=;
	h=X-UI-Sender-Class:Content-Type:Message-ID:Date:MIME-Version:From:
	 Subject:To:Cc:References:In-Reply-To:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lmsgdvLpHWXfMGc592YU3CsO56a5w25svAIHi/qcuKA0WXvzFJX+q7BLKOisf949
	 OoJ3cKsGWwKJM7cblP7zwbmemUtT/I4M3JjWfNao1nUzBeLDeoTLoU9auDxtYq9uA
	 CVw96dv7UcarpAc+Ac4lcgH71EcHAYlTtdrzpxRto+9eBuYGnDVxGt4DsvvWXffgQ
	 Ie2qy0VFG3tf/BRqJc7VTW/tGG9D03cWZUTwxKTj4PaoAqk1IZOrXMQT1EwuVXHw3
	 HTIyotRa7YE8p4aWZsPwh4ac4aM2yq12N+oGcMqqQnJJrZ9fXLG91i+kQYCDpNPQ8
	 hTiab5GPuckC8hpoNA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2O2Q-1wzgAV3h1y-004sD0; Mon, 07
 Sep 2026 13:11:02 +0200
Content-Type: multipart/mixed; boundary="------------DxO2U0GbQDeNP5RmUrM4miFM"
Message-ID: <81ac70ae-c51e-4960-8dd3-bed47ceafafb@gmx.net>
Date: Mon, 7 Sep 2026 13:11:00 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: lxuser <dittrich.m@gmx.net>
Subject: Re: [REGRESSION] PCI BAR allocation/D3cold failure: NVIDIA MX250
 inaccessible since Kernel 6.x on Acer Swift 3 (SF314-56G)
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 regressions@lists.linux.dev, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Bjorn Helgaas <helgaas@kernel.org>
References: <20260501165542.GA491695@bhelgaas>
 <561131dd-0e42-437a-9724-a036238a9bb4@gmx.net>
 <5f716613-d996-46db-96ec-6c0251219922@gmx.net>
 <449c834d-d115-4242-aa5a-43daa085f178@leemhuis.info>
Content-Language: en-US
In-Reply-To: <449c834d-d115-4242-aa5a-43daa085f178@leemhuis.info>
X-Provags-ID: V03:K1:ItZLbI2GWcPnBS4DjYuWnaE6LSuWM6zYfLW9kR+kNATBXa6WEHT
 +xWWIrsSxtAOdAKTkru3GmIy1Y4dEEus1eIcf++T76AQy50hSwK9NmO6PnCrlNkhq94wEDU
 Za4x/327sAI5Q5IrkqkrGL2HAghQlFi7PBYuc05SOM0HLzCpu1T0KgzQIv1BoQ0ERpwxQ/X
 sYJz4rP37Krd8k5rLxRGQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4YQkiDr5Po4=;a01qogNSqoQoBWd91+n6KE5Okc1
 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
 6UdXE6WPObQ+0j5uqgFuOLUQ7OTTEtVU+x91pKg=

This is a multi-part message in MIME format.
--------------DxO2U0GbQDeNP5RmUrM4miFM
Content-Type: multipart/alternative;
 boundary="------------iAyFZCd0H59Grgk4Ouf6H5el"

--------------iAyFZCd0H59Grgk4Ouf6H5el
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Dear Kernel Team,

I tested everything again with the result, that the regression is still=20
in the current kernel. This time I found the bug report from THUNDEROBOT=
=20
ZERO (https://bugzilla.kernel.org/show_bug.cgi?id=3D221087).

I tested the same patch from THUNDEROBOT ZERO but changed the model to=20
my laptop:
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DMI_MATCH(DMI_SYS_VENDOR, "Acer=
"),
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DMI_MATCH(DMI_PRODUCT_NAME, "Sw=
ift SF314-56G"),
(from dmidecode -s system-product-name and dmidecode -s system-manufacture=
r)

As an result everything works perfect. Please find the kernel patch=20
attached (acer-swift3-quirk-final.patch).

Tested with Kernel 7.2.3-1-cachyos. For further information I added=20
the=C2=A0log from sudo dmesg | grep -i=20
"nvidia\|acpi.*power\|D3cold\|64-bit\|BAR" from the original kernel and=20
the patched kernel.



kind regards
Matthias



Am 16.05.26 um 16:29 schrieb Thorsten Leemhuis:
> On 5/16/26 12:16, Matthias Dittrich wrote:
>> I completed the bisect test between kernel 5.15 und 5.16 and found the
>> commit and now have reproducible revert-test results. I used the
>> bisect.sh (attached ) for automation. Testing criteria was status rev f=
f
>> (bad) or rev a1 (good).=C2=A0 As it was the first indicator for me on U=
buntu.
>> I also used olddefconfig as I know this config worked before.
>>
>> The identified commit (see final-bisect-log.txt) is:
>> # first bad commit: [a1224f34d72a103829d6953935d6c6621f135b83] ACPI: PM=
:
>> Check states of power resources during initialization
> Thx for the bisection. Not my area of expertise, so the following might
> send everyone in the wrong direction, nevertheless FWIW:
>
> That commit caused trouble on two other machines and DMI quirks were
> added to make them work again; see 9b04d99788cf47 ("ACPI: PM: Do not
> turn of unused power resources on the Toshiba Click Mini") [v6.4-rc1]
> and cd7ef20ba8c6e9 ("ACPI: PM: Add unused power resource quirk for
> THUNDEROBOT ZERO") [v7.0-rc1] for details. Wonder if the problem on your
> machine is similar.
>
> Ciao, Thorsten
>
>> Additionally testing (see Abschlusstest.txt):
>>
>>    * Verification with=C2=A0Parent commit test: git checkout
>>      a1224f34d72a103829d6953935d6c6621f135b83~1
>>        o lspci reports `rev a1` and=C2=A0 `nvidia-smi` works correctly
>>    * Revert test on 5.16 with=C2=A0git revert --no-commit
>>      a1224f34d72a103829d6953935d6c6621f135b83
>>        o =C2=A0 =C2=A0 lspci reports `rev a1` and=C2=A0 `nvidia-smi` wo=
rks correctly
>>    * Revert test on 6.1 with=C2=A0git revert --no-commit
>>      a1224f34d72a103829d6953935d6c6621f135b83
>>        o lspci reports `rev a1` and=C2=A0 `nvidia-smi` works correctly
>>
>> With kernels like 6.2 and newer "git revert" result in an error and
>> stops (transleted to english):
>>
>> git revert --no-commit a1224f34d72a103829d6953935d6c6621f135b83 Auto-
>> merging drivers/acpi/power.c CONFLICT (content): Merge conflict in
>> drivers/acpi/power.c error: could not revert a1224f34d72a... (ACPI: PM:
>> Check states of power resources during initialization) Hint: After
>> resolving the conflicts, mark the corrected paths with: Hint: 'git add
>> <paths>' or 'git rm <paths>'
>>
>> All tests have been done with Ubuntu 22.04.
>>
>> Let me know if I can test anything further.
>>
>>
>> Test summary Ubuntu:
>>
>> Test Case
>>
>> =09
>>
>> Kernel / Commit
>>
>> =09
>>
>> Modification
>>
>> =09
>>
>> PCI State
>>
>> =09
>>
>> |Nvidia-smi/
>> NVIDIA Driver|
>>
>> =09
>>
>> Result
>>
>> Baseline good
>> Ubuntu 22.04
>>
>> =09
>>
>> Linux 5.15
>>
>> =09
>>
>> none
>>
>> =09
>>
>> |rev a1|
>>
>> =09
>>
>> works
>>
>> =09
>>
>> GOOD
>>
>> Baseline bad
>>
>> =09
>>
>> Linux 5.16
>>
>> =09
>>
>> none
>>
>> =09
>>
>> |rev ff|
>>
>> =09
>>
>> fails
>>
>> =09
>>
>> BAD
>>
>> Bisect parent
>>
>> =09
>>
>> |a1224f34...~1|
>>
>> =09
>>
>> none
>>
>> =09
>>
>> |rev a1|
>>
>> =09
>>
>> works
>>
>> =09
>>
>> GOOD
>>
>> First bad commit
>>
>> =09
>>
>> |a1224f34...|
>>
>> =09
>>
>> none
>>
>> =09
>>
>> |rev ff|
>>
>> =09
>>
>> fails
>>
>> =09
>>
>> BAD
>>
>> Revert verification
>>
>> =09
>>
>> |a1224f34...|
>>
>> =09
>>
>> reverted
>>
>> =09
>>
>> |rev a1|
>>
>> =09
>>
>> works
>>
>> =09
>>
>> GOOD
>>
>> Forward revert test
>>
>> =09
>>
>> Linux 6.1
>>
>> =09
>>
>> reverted
>>
>> =09
>>
>> |rev a1|
>>
>> =09
>>
>> works
>>
>> =09
>>
>> GOOD
>>
>> Ubuntu 22.04 (standard)
>>
>> =09
>>
>> Linux 6.8
>>
>> =09
>>
>> none
>>
>> =09
>>
>> |rev ff|
>>
>> =09
>>
>> fails
>>
>> =09
>>
>> BAD
>>
>> Modern revert attempt
>>
>> =09
>>
>> Linux 6.2
>>
>> =09
>>
>> revert attempted
>>
>> =09
>>
>> conflict in |drivers/acpi/power.c|
>>
>> =09
>>
>> n/a
>>
>> =09
>>
>> not testable
>>
>> *Linux 5.15 is the standard in Ubuntu 20.04 but also available as
>> downgrade in Ubuntu 22.04
>>
>> Test summary CachyOS:
>>
>> Test Case
>>
>> =09
>>
>> Kernel / Commit
>>
>> =09
>>
>> Modification
>>
>> =09
>>
>> PCI State
>>
>> =09
>>
>> |Nvidia-smi/
>> NVIDIA Driver|
>>
>> =09
>>
>> Result
>>
>> Standard
>>
>> =09
>>
>> Linux 7.0.2
>>
>> =09
>>
>> none
>>
>> =09
>>
>> |rev a1|
>>
>> =09
>>
>> fails
>>
>> =09
>>
>> BAD
>>
>> LTS
>>
>> =09
>>
>> Linux 6.18
>>
>> =09
>>
>> none
>>
>> =09
>>
>> |rev a1|
>>
>> =09
>>
>> fails
>>
>> =09
>>
>> BAD
>>
>> Start parameter
>>
>> =09
>>
>> |Linux ||7.0.2|
>>
>> =09
>>
>> start parameter
>>
>> =09
>>
>> |-|
>>
>> =09
>>
>> fails
>>
>> =09
>>
>> BAD
>>
>> git
>>
>> =09
>>
>> |Linux ||5.15|
>>
>> =09
>>
>> none
>>
>> =09
>>
>>
>> =09
>>
>>
>> =09
>>
>> not testable system freeze
>>
>> git
>>
>> =09
>>
>> |Linux ||7.0.2|
>>
>> =09
>>
>> revert attempted
>>
>> =09
>>
>>
>> =09
>>
>>
>> =09
>>
>> not testable
>>
>>
>> Kind regards,
>> Matthias
>>
>> Am 11.05.2026 um 11:34 schrieb Matthias Dittrich:
>>> Dear Bjorn,
>>>
>>> Thank you for the quick response. For transparency, I used the AI tool
>>> Gemini during the bug-fixing and testing process. I am not an IT
>>> specialist and therefore cannot fully verify all of the AI=E2=80=99s
>>> conclusions in my last mail.
>>>
>>> All kernels were tested manually by installing the OS and kernel. The
>>> recommended boot parameters were also tested=C2=A0manually. The logs s=
ent
>>> previously and in this mail are raw terminal outputs generated from
>>> the commands listed in the "Skript" file.
>>>
>>>
>>> The=C2=A0dmesg and |lspci|output from the newest CachyOS kernel is
>>> attached.=C2=A0Additionally, the following commands were also run for =
the
>>> Ubuntu 5.15 kernel for comparison:
>>>
>>> dmesg
>>> sudo lspci -vv > lspci-vv-ubuntu2205-K515-good.txt
>>> sudo lspci -vvv > lspci-vvv-ubuntu2205-K515-good.txt
>>> sudo lspci -vvxxxx > lspci-vvxxxx-ubuntu2205-K515-good.txt
>>> sudo lspci -s 02:00.0 -vvxxxx > lspci_gpu_$(uname -r).txt
>>> sudo lspci -t > lspci_tree_$(uname -r).txt
>>>
>>>
>>> Gemini recommended performing a git bisect with optimized parameters
>>> to reduce compilation time.
>>>
>>>    * Before starting the bisect tests, I tested different kernel
>>>      revisions. The "git" kernel 5.15 (with localmodconfig) appears to
>>>      work just like the newer Ubuntu 5.15 kernel, as the graphics card
>>>      status is shown as |(rev a1)|. The earliest=C2=A0kernel revision =
where
>>>      the status changes to |(rev ff)|starts with kernel 5.16 (tested
>>>      with localmodconfig). However, the NVIDIA driver itself could not
>>>      be tested.
>>>    * The bisect between 5.15 and 5.16 result in|
>>>      =C2=A0[342a67f0884293639bd17ea44df754ead799e669]||=C2=A0NFS: Labe=
l the
>>>      dentry with a verifier in nfs_link(), nfs_symlink()|, which seems
>>>      incorrect, as the verification using |git checkout
>>>      342a67f0884293639bd17ea44df754ead799e669~1|also failed.
>>>    * An automated bisect was attempted without localmodconfig, but
>>>      there were technical issues and I have not yet been able to
>>>      complete the testing.
>>>
>>> I also noticed that the |lspci|results differ between CachyOS and Ubun=
tu:
>>>
>>> 02:00.0 3D controller: NVIDIA Corporation GP108M [GeForce MX250] (rev =
a1)
>>>
>>>    * |(rev a1)|=E2=80=94 Ubuntu 22.04 Kernel 5.15 (works), CachyOS Ker=
nel 6.1
>>>      LTS and Kernel 7, but NVIDIA MX150 does not work
>>>    * |(rev ff)|=E2=80=94 Ubuntu 22.04 Kernel 5.16 and newer (localmodc=
onfig)
>>>      and Kernel 6.8 and=C2=A0NVIDIA MX150 does not work
>>>
>>> Kind regards,
>>> Matthias
>>>
>>>
>>>
>>> Am 01.05.2026 um 18:55 schrieb Bjorn Helgaas:
>>>> [+cc Ilpo]
>>>>
>>>> On Fri, May 01, 2026 at 10:13:41AM +0200, Matthias Dittrich wrote:
>>>>> Dear Kernel Developers,
>>>>>
>>>>> I found a regression and did my best to identify the issue and find =
a
>>>>> workaround, but I am not a developer. I also published the regressio=
n in the
>>>>> NVIDIA Linux Developer Forum, but it appears to be a kernel regressi=
on and
>>>>> not a driver issue, as the latest drivers work on older kernels (e.g=
., 5.15)
>>>>> but fail on anything 6.x+. I did not perform a git bisect as compili=
ng on
>>>>> this i5-8265U - because of its low performance I can only compile on=
e kernel
>>>>> over night.
>>>>>
>>>>> **Description:**
>>>>> The NVIDIA MX250 GPU on Acer Swift 3 (SF314-56G / BIOS 1.14) is inac=
cessible
>>>>> on any Linux distribution using Kernel 6.x or 7.x. The device fails =
to
>>>>> initialize during the driver probe routine.
>>>> Thanks for the report.  With the newest kernel available to you, can
>>>> you please capture the complete dmesg and output of "sudo lspci -vv"?
>>>> Don't filter out things that don't seem relevant; we can easily do
>>>> that.
>>>>
>>>> Bjorn

--------------iAyFZCd0H59Grgk4Ouf6H5el
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF-=
8">
  </head>
  <body>
    <p>Dear Kernel Team,</p>
    <p>I tested everything again with the result, that the regression is
      still in the current kernel. This time I found the bug report
      from=C2=A0<span style=3D"white-space: pre-wrap">THUNDEROBOT ZERO (</=
span><a
        class=3D"moz-txt-link-freetext"
        href=3D"https://bugzilla.kernel.org/show_bug.cgi?id=3D221087">http=
s://bugzilla.kernel.org/show_bug.cgi?id=3D221087</a>).<br>
      <br>
    </p>
    <p>I tested the same patch from <span style=3D"white-space: pre-wrap">=
THUNDEROBOT ZERO</span>=C2=A0
      but changed the model to my laptop:<br>
      +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DMI_MATCH(DMI_SYS_VENDOR,=
 "Acer"),<br>
      +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DMI_MATCH(DMI_PRODUCT_NAM=
E, "Swift SF314-56G"),<br>
      (from dmidecode -s system-product-name and dmidecode -s
      system-manufacturer)</p>
    <p>As an result everything works perfect. Please find the kernel
      patch attached (acer-swift3-quirk-final.patch).</p>
    <p>Tested with Kernel 7.2.3-1-cachyos. For further information I
      added the=C2=A0log from sudo dmesg | grep -i
      "nvidia\|acpi.*power\|D3cold\|64-bit\|BAR" from the original
      kernel and the patched kernel.</p>
    <p><span style=3D"font-family:monospace"><br>
        <span style=3D"color:#000000;background-color:#ffffff;"> </span><b=
r>
      </span>kind regards<br>
      Matthias</p>
    <p><br>
    </p>
    <p><br>
    </p>
    <div class=3D"moz-cite-prefix">Am 16.05.26 um 16:29 schrieb Thorsten
      Leemhuis:<br>
    </div>
    <blockquote type=3D"cite"
      cite=3D"mid:449c834d-d115-4242-aa5a-43daa085f178@leemhuis.info">
      <pre wrap=3D"" class=3D"moz-quote-pre">On 5/16/26 12:16, Matthias Di=
ttrich wrote:
</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"" class=3D"moz-quote-pre">I completed the bisect test=
 between kernel 5.15 und 5.16 and found the
commit and now have reproducible revert-test results. I used the
bisect.sh (attached ) for automation. Testing criteria was status rev ff
(bad) or rev a1 (good).=C2=A0 As it was the first indicator for me on Ubun=
tu.
I also used olddefconfig as I know this config worked before.

The identified commit (see final-bisect-log.txt) is:
# first bad commit: [a1224f34d72a103829d6953935d6c6621f135b83] ACPI: PM:
Check states of power resources during initialization
</pre>
      </blockquote>
      <pre wrap=3D"" class=3D"moz-quote-pre">Thx for the bisection. Not my=
 area of expertise, so the following might
send everyone in the wrong direction, nevertheless FWIW:

That commit caused trouble on two other machines and DMI quirks were
added to make them work again; see 9b04d99788cf47 ("ACPI: PM: Do not
turn of unused power resources on the Toshiba Click Mini") [v6.4-rc1]
and cd7ef20ba8c6e9 ("ACPI: PM: Add unused power resource quirk for
THUNDEROBOT ZERO") [v7.0-rc1] for details. Wonder if the problem on your
machine is similar.

Ciao, Thorsten

</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"" class=3D"moz-quote-pre">Additionally testing (see A=
bschlusstest.txt):

  * Verification with=C2=A0Parent commit test: git checkout
    a1224f34d72a103829d6953935d6c6621f135b83~1
      o lspci reports `rev a1` and=C2=A0 `nvidia-smi` works correctly
  * Revert test on 5.16 with=C2=A0git revert --no-commit
    a1224f34d72a103829d6953935d6c6621f135b83
      o =C2=A0 =C2=A0 lspci reports `rev a1` and=C2=A0 `nvidia-smi` works =
correctly
  * Revert test on 6.1 with=C2=A0git revert --no-commit
    a1224f34d72a103829d6953935d6c6621f135b83
      o lspci reports `rev a1` and=C2=A0 `nvidia-smi` works correctly

With kernels like 6.2 and newer "git revert" result in an error and
stops (transleted to english):

git revert --no-commit a1224f34d72a103829d6953935d6c6621f135b83 Auto-
merging drivers/acpi/power.c CONFLICT (content): Merge conflict in
drivers/acpi/power.c error: could not revert a1224f34d72a... (ACPI: PM:
Check states of power resources during initialization) Hint: After
resolving the conflicts, mark the corrected paths with: Hint: 'git add
&lt;paths&gt;' or 'git rm &lt;paths&gt;'

All tests have been done with Ubuntu 22.04.=C2=A0

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

*Linux 5.15 is the standard in Ubuntu 20.04 but also available as
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
</pre>
        <blockquote type=3D"cite">
          <pre wrap=3D"" class=3D"moz-quote-pre">Dear Bjorn,

Thank you for the quick response. For transparency, I used the AI tool
Gemini during the bug-fixing and testing process. I am not an IT
specialist and therefore cannot fully verify all of the AI=E2=80=99s
conclusions in my last mail.

All kernels were tested manually by installing the OS and kernel. The
recommended boot parameters were also tested=C2=A0manually. The logs sent
previously and in this mail are raw terminal outputs generated from
the commands listed in the "Skript" file.


The=C2=A0dmesg and |lspci|output from the newest CachyOS kernel is
attached.=C2=A0Additionally, the following commands were also run for the
Ubuntu 5.15 kernel for comparison:

dmesg
sudo lspci -vv &gt; lspci-vv-ubuntu2205-K515-good.txt
sudo lspci -vvv &gt; lspci-vvv-ubuntu2205-K515-good.txt
sudo lspci -vvxxxx &gt; lspci-vvxxxx-ubuntu2205-K515-good.txt
sudo lspci -s 02:00.0 -vvxxxx &gt; lspci_gpu_$(uname -r).txt
sudo lspci -t &gt; lspci_tree_$(uname -r).txt


Gemini recommended performing a git bisect with optimized parameters
to reduce compilation time.

  * Before starting the bisect tests, I tested different kernel
    revisions. The "git" kernel 5.15 (with localmodconfig) appears to
    work just like the newer Ubuntu 5.15 kernel, as the graphics card
    status is shown as |(rev a1)|. The earliest=C2=A0kernel revision where
    the status changes to |(rev ff)|starts with kernel 5.16 (tested
    with localmodconfig). However, the NVIDIA driver itself could not
    be tested.
  * The bisect between 5.15 and 5.16 result in|
    =C2=A0[342a67f0884293639bd17ea44df754ead799e669]||=C2=A0NFS: Label the
    dentry with a verifier in nfs_link(), nfs_symlink()|, which seems
    incorrect, as the verification using |git checkout
    342a67f0884293639bd17ea44df754ead799e669~1|also failed.
  * An automated bisect was attempted without localmodconfig, but
    there were technical issues and I have not yet been able to
    complete the testing.

I also noticed that the |lspci|results differ between CachyOS and Ubuntu:

02:00.0 3D controller: NVIDIA Corporation GP108M [GeForce MX250] (rev a1)

  * |(rev a1)|=E2=80=94 Ubuntu 22.04 Kernel 5.15 (works), CachyOS Kernel 6=
.1
    LTS and Kernel 7, but NVIDIA MX150 does not work
  * |(rev ff)|=E2=80=94 Ubuntu 22.04 Kernel 5.16 and newer (localmodconfig=
)
    and Kernel 6.8 and=C2=A0NVIDIA MX150 does not work

Kind regards,
Matthias



Am 01.05.2026 um 18:55 schrieb Bjorn Helgaas:
</pre>
          <blockquote type=3D"cite">
            <pre wrap=3D"" class=3D"moz-quote-pre">[+cc Ilpo]

On Fri, May 01, 2026 at 10:13:41AM +0200, Matthias Dittrich wrote:
</pre>
            <blockquote type=3D"cite">
              <pre wrap=3D"" class=3D"moz-quote-pre">Dear Kernel Developer=
s,

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
            <pre wrap=3D"" class=3D"moz-quote-pre">Thanks for the report. =
 With the newest kernel available to you, can
you please capture the complete dmesg and output of "sudo lspci -vv"?
Don't filter out things that don't seem relevant; we can easily do
that.

Bjorn
</pre>
          </blockquote>
        </blockquote>
      </blockquote>
      <pre wrap=3D"" class=3D"moz-quote-pre"></pre>
    </blockquote>
  </body>
</html>

--------------iAyFZCd0H59Grgk4Ouf6H5el--
--------------DxO2U0GbQDeNP5RmUrM4miFM
Content-Type: text/x-patch; charset=UTF-8;
 name="acer-swift3-quirk-final.patch"
Content-Disposition: attachment; filename="acer-swift3-quirk-final.patch"
Content-Transfer-Encoding: base64

RnJvbSA4NWFjODlmNWQzNzk5ZmJlYzljZDU0YWNhNGQ2MWMwOTJmYjUxZjRhIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBseHVzZXIgPGx4dXNlckBsb2NhbD4KRGF0ZTogTW9u
LCA3IFNlcCAyMDI2IDA5OjA0OjQ5ICswMjAwClN1YmplY3Q6IFtQQVRDSF0gQUNQSTogUE06
IEFkZCBxdWlyayBmb3IgQWNlciBTd2lmdCAzIFNGMzE0LTU2RyAoTVgyNTApCgpUaGUgQWNl
ciBTd2lmdCAzIFNGMzE0LTU2RyAod2l0aCBOVklESUEgR2VGb3JjZSBNWDI1MCkgc3VmZmVy
cyBmcm9tCnRoZSBzYW1lIEFDUEkgcG93ZXIgcmVzb3VyY2UgcmVncmVzc2lvbiBhcyB0aGUg
VGh1bmRlcm9ib3QgWkVSTy4KVGhlIHBvd2VyIHJlc291cmNlIGNvbnRyb2xsaW5nIHRoZSBk
R1BVIGlzIGluY29ycmVjdGx5IHR1cm5lZCBvZmYKZHVyaW5nIGluaXRpYWxpemF0aW9uLCBj
YXVzaW5nIHRoZSBHUFUgdG8gZmFsbCBvZmYgdGhlIGJ1cyAoRDNjb2xkKS4KClRoaXMgY29t
bWl0IGFkZHMgYSBETUkgcXVpcmsgdG8ga2VlcCB0aGUgcG93ZXIgcmVzb3VyY2Ugb24gZm9y
IHRoaXMKbW9kZWwsIHNpbWlsYXIgdG8gdGhlIGV4aXN0aW5nIFRodW5kZXJvYm90IHF1aXJr
LgoKVGVzdGVkIG9uOiBBY2VyIFN3aWZ0IDMgU0YzMTQtNTZHIHdpdGggTlZJRElBIE1YMjUw
CkZpeGVzOiBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTIy
MTA4NwpTaWduZWQtb2ZmLWJ5OiBkaXR0cmljaC5tQGdteC5uZXQKU2lnbmVkLW9mZi1ieTog
bHh1c2VyIDxseHVzZXJAbG9jYWw+Ci0tLQogZHJpdmVycy9hY3BpL3Bvd2VyLmMgfCAxMyAr
KysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvYWNwaS9wb3dlci5jIGIvZHJpdmVycy9hY3BpL3Bvd2VyLmMKaW5k
ZXggMjNhNGUyMDdhMDFlLi5jNjk1NWQxYWQyOWQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvYWNw
aS9wb3dlci5jCisrKyBiL2RyaXZlcnMvYWNwaS9wb3dlci5jCkBAIC0xMTIwLDYgKzExMjAs
MTkgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBkbWlfc3lzdGVtX2lkIGRtaV9sZWF2ZV91bnVz
ZWRfcG93ZXJfcmVzb3VyY2VzX29uW10gPSB7CiAJCQlETUlfTUFUQ0goRE1JX1BST0RVQ1Rf
TkFNRSwgIlpFUk8iKSwKIAkJfQogCisJfSwKKwl7CisJCS8qCisJCSAqIEFjZXIgU3dpZnQg
MyBTRjMxNC01Nkcgd2l0aCBOVklESUEgTVgyNTAgc3VmZmVycyBmcm9tIHRoZQorCQkgKiBz
YW1lIEFDUEkgcG93ZXIgcmVzb3VyY2UgcmVncmVzc2lvbiBhcyB0aGUgVGh1bmRlcm9ib3Qg
WkVSTy4KKwkJICogVGhlIHBvd2VyIHJlc291cmNlIGNvbnRyb2xsaW5nIHRoZSBkR1BVIGlz
IGluY29ycmVjdGx5IHR1cm5lZCBvZmYKKwkJICogZHVyaW5nIGluaXRpYWxpemF0aW9uLCBj
YXVzaW5nIHRoZSBHUFUgdG8gZmFsbCBvZmYgdGhlIGJ1cyAoRDNjb2xkKS4KKwkJICovCisJ
CS5tYXRjaGVzID0geworCQkJRE1JX01BVENIKERNSV9TWVNfVkVORE9SLCAiQWNlciIpLAor
CQkJRE1JX01BVENIKERNSV9QUk9EVUNUX05BTUUsICJTd2lmdCBTRjMxNC01NkciKSwKKwkJ
fQorCiAJfSwKIAl7fQogfTsKLS0gCjIuNTUuMAoK
--------------DxO2U0GbQDeNP5RmUrM4miFM
Content-Type: text/x-log; charset=UTF-8; name="dmesg-patch.log"
Content-Disposition: attachment; filename="dmesg-patch.log"
Content-Transfer-Encoding: base64

WyAgICAwLjAxNjU0M10gQm9vdGluZyBwYXJhdmlydHVhbGl6ZWQga2VybmVsIG9uIGJhcmUg
aGFyZHdhcmUKWyAgICAwLjE1NTgwNF0gU3BlY3RyZSBWMSA6IE1pdGlnYXRpb246IHVzZXJj
b3B5L3N3YXBncyBiYXJyaWVycyBhbmQgX191c2VyIHBvaW50ZXIgc2FuaXRpemF0aW9uClsg
ICAgMC4xNTU4MTVdIFNwZWN0cmUgVjIgOiBtaXRpZ2F0aW9uOiBFbmFibGluZyBjb25kaXRp
b25hbCBJbmRpcmVjdCBCcmFuY2ggUHJlZGljdGlvbiBCYXJyaWVyClsgICAgMC40MzI2MzFd
IEFDUEk6IFxfU0JfLlBDSTAuWERDSS5VU0JDOiBOZXcgcG93ZXIgcmVzb3VyY2UKWyAgICAw
LjQ0MjQ1MV0gQUNQSTogXF9TQl8uUENJMC5SUDA1LlBDMDE6IE5ldyBwb3dlciByZXNvdXJj
ZQpbICAgIDAuNDQzMzI0XSBBQ1BJOiBcX1NCXy5QQ0kwLlJQMDUuUENSUDogTmV3IHBvd2Vy
IHJlc291cmNlClsgICAgMC40NTc4MjBdIEFDUEk6IFxfU0JfLlBDSTAuU0FUMC5WT0wwLlYw
UFI6IE5ldyBwb3dlciByZXNvdXJjZQpbICAgIDAuNDU4MjkyXSBBQ1BJOiBcX1NCXy5QQ0kw
LlNBVDAuVk9MMS5WMVBSOiBOZXcgcG93ZXIgcmVzb3VyY2UKWyAgICAwLjQ1ODc2NF0gQUNQ
STogXF9TQl8uUENJMC5TQVQwLlZPTDIuVjJQUjogTmV3IHBvd2VyIHJlc291cmNlClsgICAg
MC40ODYxNzddIEFDUEk6IFxfU0JfLlBDSTAuQ05WVy5XUlNUOiBOZXcgcG93ZXIgcmVzb3Vy
Y2UKWyAgICAwLjUwMjI5M10gQUNQSTogXFBJTl86IE5ldyBwb3dlciByZXNvdXJjZQpbICAg
IDAuNTE0NTk2XSBwY2kgMDAwMDowMDowMi4wOiBCQVIgMCBbbWVtIDB4YTIwMDAwMDAtMHhh
MmZmZmZmZiA2NGJpdF0KWyAgICAwLjUxNDYwNl0gcGNpIDAwMDA6MDA6MDIuMDogQkFSIDIg
W21lbSAweGIwMDAwMDAwLTB4YmZmZmZmZmYgNjRiaXQgcHJlZl0KWyAgICAwLjUxNDYxMV0g
cGNpIDAwMDA6MDA6MDIuMDogQkFSIDQgW2lvICAweDQwMDAtMHg0MDNmXQpbICAgIDAuNTE1
MjY1XSBwY2kgMDAwMDowMDowNC4wOiBCQVIgMCBbbWVtIDB4YTQyMTAwMDAtMHhhNDIxN2Zm
ZiA2NGJpdF0KWyAgICAwLjUxNjE5Nl0gcGNpIDAwMDA6MDA6MTIuMDogQkFSIDAgW21lbSAw
eGE0MjI0MDAwLTB4YTQyMjRmZmYgNjRiaXRdClsgICAgMC41MTY1MzJdIHBjaSAwMDAwOjAw
OjE0LjA6IEJBUiAwIFttZW0gMHhhNDIwMDAwMC0weGE0MjBmZmZmIDY0Yml0XQpbICAgIDAu
NTE2NjAzXSBwY2kgMDAwMDowMDoxNC4wOiBQTUUjIHN1cHBvcnRlZCBmcm9tIEQzaG90IEQz
Y29sZApbICAgIDAuNTE3NzE2XSBwY2kgMDAwMDowMDoxNC4yOiBCQVIgMCBbbWVtIDB4YTQy
MjAwMDAtMHhhNDIyMWZmZiA2NGJpdF0KWyAgICAwLjUxNzcyM10gcGNpIDAwMDA6MDA6MTQu
MjogQkFSIDIgW21lbSAweGE0MjI1MDAwLTB4YTQyMjVmZmYgNjRiaXRdClsgICAgMC41MTg0
MDRdIHBjaSAwMDAwOjAwOjE0LjM6IEJBUiAwIFttZW0gMHhhNDIxODAwMC0weGE0MjFiZmZm
IDY0Yml0XQpbICAgIDAuNTE4OTI4XSBwY2kgMDAwMDowMDoxNC4zOiBQTUUjIHN1cHBvcnRl
ZCBmcm9tIEQwIEQzaG90IEQzY29sZApbICAgIDAuNTIxMjIzXSBwY2kgMDAwMDowMDoxNS4w
OiBCQVIgMCBbbWVtIDB4MDAwMDAwMDAtMHgwMDAwMGZmZiA2NGJpdF0KWyAgICAwLjUyMzQz
M10gcGNpIDAwMDA6MDA6MTUuMTogQkFSIDAgW21lbSAweDAwMDAwMDAwLTB4MDAwMDBmZmYg
NjRiaXRdClsgICAgMC41MjQ0ODJdIHBjaSAwMDAwOjAwOjE2LjA6IEJBUiAwIFttZW0gMHhh
NDIyODAwMC0weGE0MjI4ZmZmIDY0Yml0XQpbICAgIDAuNTI1OTYxXSBwY2kgMDAwMDowMDox
Ny4wOiBCQVIgMCBbbWVtIDB4YTQyMjIwMDAtMHhhNDIyM2ZmZl0KWyAgICAwLjUyNTk2Nl0g
cGNpIDAwMDA6MDA6MTcuMDogQkFSIDEgW21lbSAweGE0MjJkMDAwLTB4YTQyMmQwZmZdClsg
ICAgMC41MjU5NzFdIHBjaSAwMDAwOjAwOjE3LjA6IEJBUiAyIFtpbyAgMHg0MDgwLTB4NDA4
N10KWyAgICAwLjUyNTk3NV0gcGNpIDAwMDA6MDA6MTcuMDogQkFSIDMgW2lvICAweDQwODgt
MHg0MDhiXQpbICAgIDAuNTI1OTgwXSBwY2kgMDAwMDowMDoxNy4wOiBCQVIgNCBbaW8gIDB4
NDA2MC0weDQwN2ZdClsgICAgMC41MjU5ODRdIHBjaSAwMDAwOjAwOjE3LjA6IEJBUiA1IFtt
ZW0gMHhhNDIyYzAwMC0weGE0MjJjN2ZmXQpbICAgIDAuNTI3MjY4XSBwY2kgMDAwMDowMDox
OS4wOiBCQVIgMCBbbWVtIDB4MDAwMDAwMDAtMHgwMDAwMGZmZiA2NGJpdF0KWyAgICAwLjUy
ODUwOV0gcGNpIDAwMDA6MDA6MWMuMDogUE1FIyBzdXBwb3J0ZWQgZnJvbSBEMCBEM2hvdCBE
M2NvbGQKWyAgICAwLjUzMDU4OV0gcGNpIDAwMDA6MDA6MWMuNDogUE1FIyBzdXBwb3J0ZWQg
ZnJvbSBEMCBEM2hvdCBEM2NvbGQKWyAgICAwLjUzMjgzOV0gcGNpIDAwMDA6MDA6MWQuMDog
UE1FIyBzdXBwb3J0ZWQgZnJvbSBEMCBEM2hvdCBEM2NvbGQKWyAgICAwLjUzNDkxNV0gcGNp
IDAwMDA6MDA6MWQuNDogUE1FIyBzdXBwb3J0ZWQgZnJvbSBEMCBEM2hvdCBEM2NvbGQKWyAg
ICAwLjUzNzk4NF0gcGNpIDAwMDA6MDA6MWYuMzogQkFSIDAgW21lbSAweGE0MjFjMDAwLTB4
YTQyMWZmZmYgNjRiaXRdClsgICAgMC41MzgwMDNdIHBjaSAwMDAwOjAwOjFmLjM6IEJBUiA0
IFttZW0gMHhhNDAwMDAwMC0weGE0MGZmZmZmIDY0Yml0XQpbICAgIDAuNTM4MTUxXSBwY2kg
MDAwMDowMDoxZi4zOiBQTUUjIHN1cHBvcnRlZCBmcm9tIEQzaG90IEQzY29sZApbICAgIDAu
NTQwNDYyXSBwY2kgMDAwMDowMDoxZi40OiBCQVIgMCBbbWVtIDB4YTQyMmEwMDAtMHhhNDIy
YTBmZiA2NGJpdF0KWyAgICAwLjU0MDQ5M10gcGNpIDAwMDA6MDA6MWYuNDogQkFSIDQgW2lv
ICAweDQwNDAtMHg0MDVmXQpbICAgIDAuNTQxMjkyXSBwY2kgMDAwMDowMDoxZi41OiBCQVIg
MCBbbWVtIDB4ZmUwMTAwMDAtMHhmZTAxMGZmZl0KWyAgICAwLjU0MTgzOV0gcGNpIDAwMDA6
MDI6MDAuMDogQkFSIDAgW21lbSAweGEzMDAwMDAwLTB4YTNmZmZmZmZdClsgICAgMC41NDE4
NDZdIHBjaSAwMDAwOjAyOjAwLjA6IEJBUiAxIFttZW0gMHg5MDAwMDAwMC0weDlmZmZmZmZm
IDY0Yml0IHByZWZdClsgICAgMC41NDE4NTJdIHBjaSAwMDAwOjAyOjAwLjA6IEJBUiAzIFtt
ZW0gMHhhMDAwMDAwMC0weGExZmZmZmZmIDY0Yml0IHByZWZdClsgICAgMC41NDE4NTddIHBj
aSAwMDAwOjAyOjAwLjA6IEJBUiA1IFtpbyAgMHgzMDAwLTB4MzA3Zl0KWyAgICAwLjU0MzU4
Nl0gcGNpIDAwMDA6MDQ6MDAuMDogQkFSIDAgW21lbSAweGE0MTAwMDAwLTB4YTQxMDNmZmYg
NjRiaXRdClsgICAgMC42MzMzMzZdIHBjaSAwMDAwOjAwOjE1LjA6IEJBUiAwIFttZW0gMHhh
NDIyNjAwMC0weGE0MjI2ZmZmIDY0Yml0XTogYXNzaWduZWQKWyAgICAwLjYzMzM4NF0gcGNp
IDAwMDA6MDA6MTUuMTogQkFSIDAgW21lbSAweGE0MjI3MDAwLTB4YTQyMjdmZmYgNjRiaXRd
OiBhc3NpZ25lZApbICAgIDAuNjMzNDEyXSBwY2kgMDAwMDowMDoxOS4wOiBCQVIgMCBbbWVt
IDB4YTQyMjkwMDAtMHhhNDIyOWZmZiA2NGJpdF06IGFzc2lnbmVkClsgICAgMC43NjI5NTZd
IGF0YTE6IFNBVEEgbWF4IFVETUEvMTMzIGFiYXIgbTIwNDhAMHhhNDIyYzAwMCBwb3J0IDB4
YTQyMmMxMDAgaXJxIDEyNCBscG0tcG9sIDQKWyAgICAwLjg3MzM1M10gYWNwaSBMTlhQT1dF
UjowMjogaGFzaCBtYXRjaGVzClsgICAgMS45MDU0MzldIHN5c3RlbWRbMV06IHN5c3RlbWQg
MjYxLjItMS1hcmNoIHJ1bm5pbmcgaW4gc3lzdGVtIG1vZGUgKCtQQU0gK0FVRElUIC1TRUxJ
TlVYICtBUFBBUk1PUiAtSU1BICtJUEUgK1NNQUNLICtTRUNDT01QICtHQ1JZUFQgK0dOVVRM
UyArT1BFTlNTTCArQUNMICtCTEtJRCArQ1VSTCArRUxGVVRJTFMgK0ZJRE8yICtJRE4yICtL
TU9EICtMSUJDUllQVFNFVFVQICtMSUJDUllQVFNFVFVQX1BMVUdJTlMgK0xJQkZESVNLICtQ
Q1JFMiArUFdRVUFMSVRZICtQMTFLSVQgK1FSRU5DT0RFICtUUE0yICtCWklQMiArTFo0ICtY
WiArWkxJQiArWlNURCArQlBGX0ZSQU1FV09SSyArQlRGICtYS0JDT01NT04gK1VUTVAgK0xJ
QkFSQ0hJVkUpClsgICAgMS45NjEwMjZdIHN5c3RlbWRbMV06IFRQTSBQQ1IgQmFycmllciAo
aW5pdHJkKSBza2lwcGVkLCB1bm1ldCBjb25kaXRpb24gY2hlY2sgQ29uZGl0aW9uU2VjdXJp
dHk9bWVhc3VyZWQtb3MKWyAgICAyLjIzNzU2OF0gaWRtYTY0IGlkbWE2NC4wOiBGb3VuZCBJ
bnRlbCBpbnRlZ3JhdGVkIERNQSA2NC1iaXQKWyAgICAyLjI1OTI2N10gaWRtYTY0IGlkbWE2
NC4xOiBGb3VuZCBJbnRlbCBpbnRlZ3JhdGVkIERNQSA2NC1iaXQKWyAgICA0LjA3MjgzMV0g
c3lzdGVtZFsxXTogc3lzdGVtZCAyNjEuMi0xLWFyY2ggcnVubmluZyBpbiBzeXN0ZW0gbW9k
ZSAoK1BBTSArQVVESVQgLVNFTElOVVggK0FQUEFSTU9SIC1JTUEgK0lQRSArU01BQ0sgK1NF
Q0NPTVAgK0dDUllQVCArR05VVExTICtPUEVOU1NMICtBQ0wgK0JMS0lEICtDVVJMICtFTEZV
VElMUyArRklETzIgK0lETjIgK0tNT0QgK0xJQkNSWVBUU0VUVVAgK0xJQkNSWVBUU0VUVVBf
UExVR0lOUyArTElCRkRJU0sgK1BDUkUyICtQV1FVQUxJVFkgK1AxMUtJVCArUVJFTkNPREUg
K1RQTTIgK0JaSVAyICtMWjQgK1haICtaTElCICtaU1REICtCUEZfRlJBTUVXT1JLICtCVEYg
K1hLQkNPTU1PTiArVVRNUCArTElCQVJDSElWRSkKWyAgICA1LjM2MjM2Nl0gbnZpZGlhOiBs
b2FkaW5nIG91dC1vZi10cmVlIG1vZHVsZSB0YWludHMga2VybmVsLgpbICAgIDUuMzYyMzc0
XSBudmlkaWE6IG1vZHVsZSBsaWNlbnNlICdOVklESUEnIHRhaW50cyBrZXJuZWwuClsgICAg
NS4zNjIzNzhdIG52aWRpYTogbW9kdWxlIHZlcmlmaWNhdGlvbiBmYWlsZWQ6IHNpZ25hdHVy
ZSBhbmQvb3IgcmVxdWlyZWQga2V5IG1pc3NpbmcgLSB0YWludGluZyBrZXJuZWwKWyAgICA1
LjM2MjM3OV0gbnZpZGlhOiBtb2R1bGUgbGljZW5zZSB0YWludHMga2VybmVsLgpbICAgIDYu
MTg1MTc3XSBudmlkaWEtbnZsaW5rOiBOdmxpbmsgQ29yZSBpcyBiZWluZyBpbml0aWFsaXpl
ZCwgbWFqb3IgZGV2aWNlIG51bWJlciAyMzQKWyAgICA2LjIwMDU3M10gbnZpZGlhIDAwMDA6
MDI6MDAuMDogZW5hYmxpbmcgZGV2aWNlICgwMTA2IC0+IDAxMDcpClsgICAgNi40NDExODNd
IE5WUk06IGxvYWRpbmcgTlZJRElBIFVOSVggeDg2XzY0IEtlcm5lbCBNb2R1bGUgIDU4MC4x
NzguMDQgIFR1ZSBKdWwgIDcgMTI6Mzg6MjEgVVRDIDIwMjYKWyAgICA2LjQ4NzMyMV0gbnZp
ZGlhX3V2bTogbW9kdWxlIHVzZXMgc3ltYm9scyBudlV2bUludGVyZmFjZUR1cEFkZHJlc3NT
cGFjZSBmcm9tIHByb3ByaWV0YXJ5IG1vZHVsZSBudmlkaWEsIGluaGVyaXRpbmcgdGFpbnQu
ClsgICAgNi43ODAxNjZdIG52aWRpYSAwMDAwOjAyOjAwLjA6IEVuYWJsaW5nIEhEQSBjb250
cm9sbGVyClsgICAgNi44NDQwNjldIG52aWRpYS1tb2Rlc2V0OiBMb2FkaW5nIE5WSURJQSBL
ZXJuZWwgTW9kZSBTZXR0aW5nIERyaXZlciBmb3IgVU5JWCBwbGF0Zm9ybXMgIDU4MC4xNzgu
MDQgIFR1ZSBKdWwgIDcgMTI6MDM6MDQgVVRDIDIwMjYKWyAgICA2Ljg1NTM3NF0gW2RybV0g
W252aWRpYS1kcm1dIFtHUFUgSUQgMHgwMDAwMDIwMF0gTG9hZGluZyBkcml2ZXIKWyAgICA3
LjI1NDY2N10gW2RybV0gSW5pdGlhbGl6ZWQgbnZpZGlhLWRybSAwLjAuMCBmb3IgMDAwMDow
MjowMC4wIG9uIG1pbm9yIDAKWyAgICA3LjI1NDY5MV0gbnZpZGlhIDAwMDA6MDI6MDAuMDog
W2RybV0gTm8gY29tcGF0aWJsZSBmb3JtYXQgZm91bmQKWyAgICA3LjI1NDY5NV0gbnZpZGlh
IDAwMDA6MDI6MDAuMDogW2RybV0gQ2Fubm90IGZpbmQgYW55IGNydGMgb3Igc2l6ZXMK
--------------DxO2U0GbQDeNP5RmUrM4miFM
Content-Type: text/x-log; charset=UTF-8; name="dmesg-original.log"
Content-Disposition: attachment; filename="dmesg-original.log"
Content-Transfer-Encoding: base64

WyAgICAwLjAxNjQ3M10gQm9vdGluZyBwYXJhdmlydHVhbGl6ZWQga2VybmVsIG9uIGJhcmUg
aGFyZHdhcmUKWyAgICAwLjE1NTk3OV0gU3BlY3RyZSBWMSA6IE1pdGlnYXRpb246IHVzZXJj
b3B5L3N3YXBncyBiYXJyaWVycyBhbmQgX191c2VyIHBvaW50ZXIgc2FuaXRpemF0aW9uClsg
ICAgMC4xNTU5OTFdIFNwZWN0cmUgVjIgOiBtaXRpZ2F0aW9uOiBFbmFibGluZyBjb25kaXRp
b25hbCBJbmRpcmVjdCBCcmFuY2ggUHJlZGljdGlvbiBCYXJyaWVyClsgICAgMC40MzIyMDVd
IEFDUEk6IFxfU0JfLlBDSTAuWERDSS5VU0JDOiBOZXcgcG93ZXIgcmVzb3VyY2UKWyAgICAw
LjQ0MjAyNF0gQUNQSTogXF9TQl8uUENJMC5SUDA1LlBDMDE6IE5ldyBwb3dlciByZXNvdXJj
ZQpbICAgIDAuNDQyODcxXSBBQ1BJOiBcX1NCXy5QQ0kwLlJQMDUuUENSUDogTmV3IHBvd2Vy
IHJlc291cmNlClsgICAgMC40NTczMjddIEFDUEk6IFxfU0JfLlBDSTAuU0FUMC5WT0wwLlYw
UFI6IE5ldyBwb3dlciByZXNvdXJjZQpbICAgIDAuNDU3ODAwXSBBQ1BJOiBcX1NCXy5QQ0kw
LlNBVDAuVk9MMS5WMVBSOiBOZXcgcG93ZXIgcmVzb3VyY2UKWyAgICAwLjQ1ODI2OF0gQUNQ
STogXF9TQl8uUENJMC5TQVQwLlZPTDIuVjJQUjogTmV3IHBvd2VyIHJlc291cmNlClsgICAg
MC40ODU3OTZdIEFDUEk6IFxfU0JfLlBDSTAuQ05WVy5XUlNUOiBOZXcgcG93ZXIgcmVzb3Vy
Y2UKWyAgICAwLjUwMTk1M10gQUNQSTogXFBJTl86IE5ldyBwb3dlciByZXNvdXJjZQpbICAg
IDAuNTE0MzIxXSBwY2kgMDAwMDowMDowMi4wOiBCQVIgMCBbbWVtIDB4YTIwMDAwMDAtMHhh
MmZmZmZmZiA2NGJpdF0KWyAgICAwLjUxNDMyOF0gcGNpIDAwMDA6MDA6MDIuMDogQkFSIDIg
W21lbSAweGIwMDAwMDAwLTB4YmZmZmZmZmYgNjRiaXQgcHJlZl0KWyAgICAwLjUxNDMzM10g
cGNpIDAwMDA6MDA6MDIuMDogQkFSIDQgW2lvICAweDQwMDAtMHg0MDNmXQpbICAgIDAuNTE0
OTkwXSBwY2kgMDAwMDowMDowNC4wOiBCQVIgMCBbbWVtIDB4YTQyMTAwMDAtMHhhNDIxN2Zm
ZiA2NGJpdF0KWyAgICAwLjUxNTkxNV0gcGNpIDAwMDA6MDA6MTIuMDogQkFSIDAgW21lbSAw
eGE0MjI0MDAwLTB4YTQyMjRmZmYgNjRiaXRdClsgICAgMC41MTYyOTRdIHBjaSAwMDAwOjAw
OjE0LjA6IEJBUiAwIFttZW0gMHhhNDIwMDAwMC0weGE0MjBmZmZmIDY0Yml0XQpbICAgIDAu
NTE2MzY4XSBwY2kgMDAwMDowMDoxNC4wOiBQTUUjIHN1cHBvcnRlZCBmcm9tIEQzaG90IEQz
Y29sZApbICAgIDAuNTE3NDcxXSBwY2kgMDAwMDowMDoxNC4yOiBCQVIgMCBbbWVtIDB4YTQy
MjAwMDAtMHhhNDIyMWZmZiA2NGJpdF0KWyAgICAwLjUxNzQ4MF0gcGNpIDAwMDA6MDA6MTQu
MjogQkFSIDIgW21lbSAweGE0MjI1MDAwLTB4YTQyMjVmZmYgNjRiaXRdClsgICAgMC41MTgx
NDhdIHBjaSAwMDAwOjAwOjE0LjM6IEJBUiAwIFttZW0gMHhhNDIxODAwMC0weGE0MjFiZmZm
IDY0Yml0XQpbICAgIDAuNTE4NjgxXSBwY2kgMDAwMDowMDoxNC4zOiBQTUUjIHN1cHBvcnRl
ZCBmcm9tIEQwIEQzaG90IEQzY29sZApbICAgIDAuNTIxMTk4XSBwY2kgMDAwMDowMDoxNS4w
OiBCQVIgMCBbbWVtIDB4MDAwMDAwMDAtMHgwMDAwMGZmZiA2NGJpdF0KWyAgICAwLjUyMzQz
MV0gcGNpIDAwMDA6MDA6MTUuMTogQkFSIDAgW21lbSAweDAwMDAwMDAwLTB4MDAwMDBmZmYg
NjRiaXRdClsgICAgMC41MjQ1MDZdIHBjaSAwMDAwOjAwOjE2LjA6IEJBUiAwIFttZW0gMHhh
NDIyODAwMC0weGE0MjI4ZmZmIDY0Yml0XQpbICAgIDAuNTI1OTc1XSBwY2kgMDAwMDowMDox
Ny4wOiBCQVIgMCBbbWVtIDB4YTQyMjIwMDAtMHhhNDIyM2ZmZl0KWyAgICAwLjUyNTk4MF0g
cGNpIDAwMDA6MDA6MTcuMDogQkFSIDEgW21lbSAweGE0MjJkMDAwLTB4YTQyMmQwZmZdClsg
ICAgMC41MjU5OTNdIHBjaSAwMDAwOjAwOjE3LjA6IEJBUiAyIFtpbyAgMHg0MDgwLTB4NDA4
N10KWyAgICAwLjUyNjAwNF0gcGNpIDAwMDA6MDA6MTcuMDogQkFSIDMgW2lvICAweDQwODgt
MHg0MDhiXQpbICAgIDAuNTI2MDA5XSBwY2kgMDAwMDowMDoxNy4wOiBCQVIgNCBbaW8gIDB4
NDA2MC0weDQwN2ZdClsgICAgMC41MjYwMTVdIHBjaSAwMDAwOjAwOjE3LjA6IEJBUiA1IFtt
ZW0gMHhhNDIyYzAwMC0weGE0MjJjN2ZmXQpbICAgIDAuNTI3Mjg2XSBwY2kgMDAwMDowMDox
OS4wOiBCQVIgMCBbbWVtIDB4MDAwMDAwMDAtMHgwMDAwMGZmZiA2NGJpdF0KWyAgICAwLjUy
ODUzOV0gcGNpIDAwMDA6MDA6MWMuMDogUE1FIyBzdXBwb3J0ZWQgZnJvbSBEMCBEM2hvdCBE
M2NvbGQKWyAgICAwLjUzMDU4OV0gcGNpIDAwMDA6MDA6MWMuNDogUE1FIyBzdXBwb3J0ZWQg
ZnJvbSBEMCBEM2hvdCBEM2NvbGQKWyAgICAwLjUzMjgxNV0gcGNpIDAwMDA6MDA6MWQuMDog
UE1FIyBzdXBwb3J0ZWQgZnJvbSBEMCBEM2hvdCBEM2NvbGQKWyAgICAwLjUzNDg4Ml0gcGNp
IDAwMDA6MDA6MWQuNDogUE1FIyBzdXBwb3J0ZWQgZnJvbSBEMCBEM2hvdCBEM2NvbGQKWyAg
ICAwLjUzNzg4OF0gcGNpIDAwMDA6MDA6MWYuMzogQkFSIDAgW21lbSAweGE0MjFjMDAwLTB4
YTQyMWZmZmYgNjRiaXRdClsgICAgMC41Mzc5MDVdIHBjaSAwMDAwOjAwOjFmLjM6IEJBUiA0
IFttZW0gMHhhNDAwMDAwMC0weGE0MGZmZmZmIDY0Yml0XQpbICAgIDAuNTM4MDYyXSBwY2kg
MDAwMDowMDoxZi4zOiBQTUUjIHN1cHBvcnRlZCBmcm9tIEQzaG90IEQzY29sZApbICAgIDAu
NTQwNDA4XSBwY2kgMDAwMDowMDoxZi40OiBCQVIgMCBbbWVtIDB4YTQyMmEwMDAtMHhhNDIy
YTBmZiA2NGJpdF0KWyAgICAwLjU0MDQ0MF0gcGNpIDAwMDA6MDA6MWYuNDogQkFSIDQgW2lv
ICAweDQwNDAtMHg0MDVmXQpbICAgIDAuNTQxMjQ5XSBwY2kgMDAwMDowMDoxZi41OiBCQVIg
MCBbbWVtIDB4ZmUwMTAwMDAtMHhmZTAxMGZmZl0KWyAgICAwLjU0MTc3MV0gcGNpIDAwMDA6
MDI6MDAuMDogQkFSIDAgW21lbSAweGEzMDAwMDAwLTB4YTNmZmZmZmZdClsgICAgMC41NDE3
NzhdIHBjaSAwMDAwOjAyOjAwLjA6IEJBUiAxIFttZW0gMHg5MDAwMDAwMC0weDlmZmZmZmZm
IDY0Yml0IHByZWZdClsgICAgMC41NDE3ODVdIHBjaSAwMDAwOjAyOjAwLjA6IEJBUiAzIFtt
ZW0gMHhhMDAwMDAwMC0weGExZmZmZmZmIDY0Yml0IHByZWZdClsgICAgMC41NDE3OTBdIHBj
aSAwMDAwOjAyOjAwLjA6IEJBUiA1IFtpbyAgMHgzMDAwLTB4MzA3Zl0KWyAgICAwLjU0MzUy
Nl0gcGNpIDAwMDA6MDQ6MDAuMDogQkFSIDAgW21lbSAweGE0MTAwMDAwLTB4YTQxMDNmZmYg
NjRiaXRdClsgICAgMC43NTAxNzNdIHBjaSAwMDAwOjAwOjE1LjA6IEJBUiAwIFttZW0gMHhh
NDIyNjAwMC0weGE0MjI2ZmZmIDY0Yml0XTogYXNzaWduZWQKWyAgICAwLjc1MDIyMV0gcGNp
IDAwMDA6MDA6MTUuMTogQkFSIDAgW21lbSAweGE0MjI3MDAwLTB4YTQyMjdmZmYgNjRiaXRd
OiBhc3NpZ25lZApbICAgIDAuNzUwMjYwXSBwY2kgMDAwMDowMDoxOS4wOiBCQVIgMCBbbWVt
IDB4YTQyMjkwMDAtMHhhNDIyOWZmZiA2NGJpdF06IGFzc2lnbmVkClsgICAgMC44ODEzMDZd
IGF0YTE6IFNBVEEgbWF4IFVETUEvMTMzIGFiYXIgbTIwNDhAMHhhNDIyYzAwMCBwb3J0IDB4
YTQyMmMxMDAgaXJxIDEyNCBscG0tcG9sIDQKWyAgICAyLjAwODY5MV0gc3lzdGVtZFsxXTog
c3lzdGVtZCAyNjEuMi0xLWFyY2ggcnVubmluZyBpbiBzeXN0ZW0gbW9kZSAoK1BBTSArQVVE
SVQgLVNFTElOVVggK0FQUEFSTU9SIC1JTUEgK0lQRSArU01BQ0sgK1NFQ0NPTVAgK0dDUllQ
VCArR05VVExTICtPUEVOU1NMICtBQ0wgK0JMS0lEICtDVVJMICtFTEZVVElMUyArRklETzIg
K0lETjIgK0tNT0QgK0xJQkNSWVBUU0VUVVAgK0xJQkNSWVBUU0VUVVBfUExVR0lOUyArTElC
RkRJU0sgK1BDUkUyICtQV1FVQUxJVFkgK1AxMUtJVCArUVJFTkNPREUgK1RQTTIgK0JaSVAy
ICtMWjQgK1haICtaTElCICtaU1REICtCUEZfRlJBTUVXT1JLICtCVEYgK1hLQkNPTU1PTiAr
VVRNUCArTElCQVJDSElWRSkKWyAgICAyLjA2NTI2N10gc3lzdGVtZFsxXTogVFBNIFBDUiBC
YXJyaWVyIChpbml0cmQpIHNraXBwZWQsIHVubWV0IGNvbmRpdGlvbiBjaGVjayBDb25kaXRp
b25TZWN1cml0eT1tZWFzdXJlZC1vcwpbICAgIDIuMzQ4NjU2XSBpZG1hNjQgaWRtYTY0LjA6
IEZvdW5kIEludGVsIGludGVncmF0ZWQgRE1BIDY0LWJpdApbICAgIDIuMzYwMjUzXSBpZG1h
NjQgaWRtYTY0LjE6IEZvdW5kIEludGVsIGludGVncmF0ZWQgRE1BIDY0LWJpdApbICAgIDQu
MDk3MjE4XSBzeXN0ZW1kWzFdOiBzeXN0ZW1kIDI2MS4yLTEtYXJjaCBydW5uaW5nIGluIHN5
c3RlbSBtb2RlICgrUEFNICtBVURJVCAtU0VMSU5VWCArQVBQQVJNT1IgLUlNQSArSVBFICtT
TUFDSyArU0VDQ09NUCArR0NSWVBUICtHTlVUTFMgK09QRU5TU0wgK0FDTCArQkxLSUQgK0NV
UkwgK0VMRlVUSUxTICtGSURPMiArSUROMiArS01PRCArTElCQ1JZUFRTRVRVUCArTElCQ1JZ
UFRTRVRVUF9QTFVHSU5TICtMSUJGRElTSyArUENSRTIgK1BXUVVBTElUWSArUDExS0lUICtR
UkVOQ09ERSArVFBNMiArQlpJUDIgK0xaNCArWFogK1pMSUIgK1pTVEQgK0JQRl9GUkFNRVdP
UksgK0JURiArWEtCQ09NTU9OICtVVE1QICtMSUJBUkNISVZFKQpbICAgIDUuMzA1ODY3XSBu
dmlkaWE6IGxvYWRpbmcgb3V0LW9mLXRyZWUgbW9kdWxlIHRhaW50cyBrZXJuZWwuClsgICAg
NS4zMDU4NzRdIG52aWRpYTogbW9kdWxlIGxpY2Vuc2UgJ05WSURJQScgdGFpbnRzIGtlcm5l
bC4KWyAgICA1LjMwNTg3OF0gbnZpZGlhOiBtb2R1bGUgdmVyaWZpY2F0aW9uIGZhaWxlZDog
c2lnbmF0dXJlIGFuZC9vciByZXF1aXJlZCBrZXkgbWlzc2luZyAtIHRhaW50aW5nIGtlcm5l
bApbICAgIDUuMzA1ODc5XSBudmlkaWE6IG1vZHVsZSBsaWNlbnNlIHRhaW50cyBrZXJuZWwu
ClsgICAgNi4wNjkzNTJdIG52aWRpYS1udmxpbms6IE52bGluayBDb3JlIGlzIGJlaW5nIGlu
aXRpYWxpemVkLCBtYWpvciBkZXZpY2UgbnVtYmVyIDUxMQpbICAgIDYuMDc4ODk1XSBudmlk
aWEgMDAwMDowMjowMC4wOiBVbmFibGUgdG8gY2hhbmdlIHBvd2VyIHN0YXRlIGZyb20gRDNj
b2xkIHRvIEQwLCBkZXZpY2UgaW5hY2Nlc3NpYmxlClsgICAgNi4wNzkwOTldIE5WUk06IFRo
ZSBOVklESUEgR1BVIDAwMDA6MDI6MDAuMApbICAgIDYuMDc5MjMyXSBudmlkaWEgMDAwMDow
MjowMC4wOiBwcm9iZSB3aXRoIGRyaXZlciBudmlkaWEgZmFpbGVkIHdpdGggZXJyb3IgLTEK
WyAgICA2LjA3OTI2Nl0gTlZSTTogVGhlIE5WSURJQSBwcm9iZSByb3V0aW5lIGZhaWxlZCBm
b3IgMSBkZXZpY2UocykuClsgICAgNi4wNzkyNjldIE5WUk06IE5vbmUgb2YgdGhlIE5WSURJ
QSBkZXZpY2VzIHdlcmUgaW5pdGlhbGl6ZWQuClsgICAgNi4wODAzNjZdIG52aWRpYS1udmxp
bms6IFVucmVnaXN0ZXJlZCBOdmxpbmsgQ29yZSwgbWFqb3IgZGV2aWNlIG51bWJlciA1MTEK
WyAgICA3LjQ5ODY0Nl0gbnZpZGlhLW52bGluazogTnZsaW5rIENvcmUgaXMgYmVpbmcgaW5p
dGlhbGl6ZWQsIG1ham9yIGRldmljZSBudW1iZXIgNTA5ClsgICAgNy41MDYyMjldIG52aWRp
YSAwMDAwOjAyOjAwLjA6IFVuYWJsZSB0byBjaGFuZ2UgcG93ZXIgc3RhdGUgZnJvbSBEM2Nv
bGQgdG8gRDAsIGRldmljZSBpbmFjY2Vzc2libGUKWyAgICA3LjUwNjM3M10gTlZSTTogVGhl
IE5WSURJQSBHUFUgMDAwMDowMjowMC4wClsgICAgNy41MDY0NTJdIG52aWRpYSAwMDAwOjAy
OjAwLjA6IHByb2JlIHdpdGggZHJpdmVyIG52aWRpYSBmYWlsZWQgd2l0aCBlcnJvciAtMQpb
ICAgIDcuNTA2NDY5XSBOVlJNOiBUaGUgTlZJRElBIHByb2JlIHJvdXRpbmUgZmFpbGVkIGZv
ciAxIGRldmljZShzKS4KWyAgICA3LjUwNjQ3MF0gTlZSTTogTm9uZSBvZiB0aGUgTlZJRElB
IGRldmljZXMgd2VyZSBpbml0aWFsaXplZC4KWyAgICA3LjUwNzYzN10gbnZpZGlhLW52bGlu
azogVW5yZWdpc3RlcmVkIE52bGluayBDb3JlLCBtYWpvciBkZXZpY2UgbnVtYmVyIDUwOQo=


--------------DxO2U0GbQDeNP5RmUrM4miFM--
