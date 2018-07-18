Return-Path: <SRS0=oBiH=KC=molgen.mpg.de=pmenzel@kernel.org>
Return-Path: <SRS0=oBiH=KC=molgen.mpg.de=pmenzel@kernel.org>
Subject: Re: NULL pointer dereference in msi_set_mask_bit
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Marc Zyngier <marc.zyngier@arm.com>
References: <b9bd8405-64b6-2bea-f5ce-d3ab4d82452a@molgen.mpg.de>
 <20180718140636.GD128988@bhelgaas-glaptop.roam.corp.google.com>
 <alpine.DEB.2.21.1807181646280.1568@nanos.tec.linutronix.de>
 <6339fdef-a335-b833-4022-23725fd86d9e@molgen.mpg.de>
 <alpine.DEB.2.21.1807181722020.1568@nanos.tec.linutronix.de>
From: Paul Menzel <pmenzel+linux-pci@molgen.mpg.de>
Message-ID: <178bb701-56af-06cf-4836-1a26e74f2b07@molgen.mpg.de>
Date: Wed, 18 Jul 2018 18:37:46 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1807181722020.1568@nanos.tec.linutronix.de>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms070600080708010209040409"
List-ID: <linux-pci.vger.kernel.org>

This is a cryptographically signed message in MIME format.

--------------ms070600080708010209040409
Content-Type: multipart/mixed;
 boundary="------------3B68743274E29E999A7F8554"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------3B68743274E29E999A7F8554
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[I removed the folks from the unrelated patches.]

Dear Thomas,


On 07/18/18 17:39, Thomas Gleixner wrote:

> On Wed, 18 Jul 2018, Paul Menzel wrote:
>> On 07/18/18 17:02, Thomas Gleixner wrote:
>>>>> 93.885: [   23.020572] BUG: unable to handle kernel NULL pointer de=
reference at 000000000000003c
>>>>> 93.885: [   23.029011] PGD 0 P4D 0=20
>>>>> 93.885: [   23.031670] Oops: 0000 [#1] SMP NOPTI
>>>>> 93.885: [   23.035455] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.=
18.0-rc5+ #1
>>>>> 93.885: [   23.042079] Hardware name: MSI MS-7A37/B350M MORTAR (MS-=
7A37), BIOS 1.G1 05/17/2018
>>>>> 93.886: [   23.049868] RIP: 0010:msi_set_mask_bit+0xe/0x70
>>>
>>>>> 93.913: [   23.049868] Code: 00 53 48 89 fb e8 12 f8 ff ff 48 89 df=
 5b e9 c9 fe ff ff 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 53 48 8b 47 =
10 48 8b 58 10 <f6> 43 3c 01 74 3c 8b 15 2e 85 21 01 31 c0 85 d2 75 25 8b=
 43 38 48
>>>
>>>   f6 43 3c 01          	testb  $0x1,0x3c(%rbx)
>>>
>>> That's:
>>>
>>> 	if (desc->msi_attrib.is_msix)
>>
>> Is there a tool to translate that?
>=20
> That tool is called brain :)
>=20
> Seriously, what you can do is run the 'Code: ...' line through
> scripts/decodecode and that will show you the disassembly. Now staring =
at
> msi_set_mask_bit() makes it pretty obvious which part it is and the off=
set of
> msi_attrib in msi_desc is 0x3c, which matches the BUG: line above. You =
can
> figure that out by counting or by using pahole.
>=20
> Of course if you have the vmlinux around then scripts/faddr2line is wha=
t
> you want to use.

Thank you for the explanation. I=E2=80=99ll keep that in mind for the fut=
ure.

>>>>> 93.957: [   23.049880] RSP: 0018:ffff9e8e5e803f78 EFLAGS: 00010046
>>>>> 93.957: [   23.049881] RAX: ffff9e8e45919000 RBX: 0000000000000000 =
RCX: 0000000000000000
>>>>> 93.958: [   23.049882] RDX: ffff9e8e45919000 RSI: 0000000000000001 =
RDI: ffff9e8e45919098
>>>>> 93.958: [   23.049882] RBP: ffff9e8e45919098 R08: 0000000000000000 =
R09: 0000000000000000
>>>>> 93.958: [   23.049882] R10: 0000000000000000 R11: 0000000000000000 =
R12: ffff9e8e45919000
>>>>> 93.958: [   23.049883] R13: 0000000000000027 R14: 0000000000000000 =
R15: 0000000000000000
>>>>> 93.959: [   23.049884] FS:  0000000000000000(0000) GS:ffff9e8e5e800=
000(0000) knlGS:0000000000000000
>>>>> 93.959: [   23.049884] CS:  0010 DS: 0000 ES: 0000 CR0: 00000000800=
50033
>>>>> 93.959: [   23.049885] CR2: 000000000000003c CR3: 00000003fc5a4000 =
CR4: 00000000003406f0
>>>>> 93.959: [   23.049885] Call Trace:
>>>>> 93.959: [   23.049887]  <IRQ>
>>>>> 93.960: [   23.049889]  __irq_move_irq+0x3c/0x70
>>>>> 93.960: [   23.049892]  apic_ack_irq+0x2b/0x30
>>>>> 93.960: [   23.049893]  handle_edge_irq+0x7d/0x1d0
>>>>> 93.960: [   23.049895]  handle_irq+0x1f/0x30
>>>>> 93.960: [   23.049898]  do_IRQ+0x41/0xc0
>>>>> 93.960: [   23.049899]  common_interrupt+0xf/0xf
>>>>> 93.961: [   23.049900]  </IRQ>
>>>
>>> and desc comes from irq_data->common->msi_desc
>>>
>>> I have no idea how that can happen for an MSI interrupt.
>>>
>>> Paul, is this reproducible?
>>
>> No, unfortunately not. I only hit this once, since I attached the seri=
al
>> console.
>=20
> Bah. Could you please enable GENERIC_IRQ_DEBUGFS and after a successful=

> boot up provide me the content of all files in /sys/kernel/debug/irq/ a=
nd
> its subfolders?

Sure, please find them attached. `7zr x sys-kernel-debug-irq.7z` should
extract it.

```
$ sudo ls -R /sys/kernel/debug/irq/
/sys/kernel/debug/irq/:
domains  irqs

/sys/kernel/debug/irq/domains:
AMD-IR-0  AMD-IR-MSI-0-2  default  IO-APIC-IR-0  IO-APIC-IR-1  PCI-MSI-2 =
 VECTOR

/sys/kernel/debug/irq/irqs:
0   11	14  24	27  3	32  35	38  40	43  46	49  51	54  6  9
1   12	15  25	28  30	33  36	39  41	44  47	5   52	55  7
10  13	2   26	29  31	34  37	4   42	45  48	50  53	56  8
```

> I assume you have irqbalanced running, right?

Yes, I do.

```
$ systemctl status irqbalance
=E2=97=8F irqbalance.service - irqbalance daemon
   Loaded: loaded (/lib/systemd/system/irqbalance.service; enabled; vendo=
r preset: enabled)
   Active: active (running) since Wed 2018-07-18 18:26:05 CEST; 5min ago
 Main PID: 491 (irqbalance)
    Tasks: 2 (limit: 4915)
   Memory: 1.4M
   CGroup: /system.slice/irqbalance.service
           =E2=94=94=E2=94=80491 /usr/sbin/irqbalance --foreground

Jul 18 18:26:05 tokeiihto systemd[1]: Started irqbalance daemon.
```


Kind regards,

Paul

--------------3B68743274E29E999A7F8554
Content-Type: application/x-7z-compressed;
 name="sys-kernel-debug-irq.7z"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="sys-kernel-debug-irq.7z"

N3q8ryccAASOnsReKAEAAAAAAAAiAAAAAAAAAD/eS3MAAIGDn3CqAaAlOd+TL4I7big6ZIfB
atwb8aMCVdWzInGe28D1nZKVy2yx1ftL0OGsU2DVKUkHTQe0GQyi4t3rEV/FWr3B/+nWR3YQ
6lz6Nek4BCSWhro/czjHKqtRG40MqbMOImKRXq0wF7GqujuOht8YmPSDIFhAD0l7dfLBL0EV
Gk6rAXz6bKcAV45IKIjFF/mN2AQtsmZ9BOC3RoeRZlkZliosL0uSQKYHfcXT28f1iznIitIT
a5G6G3X3AbrZkUcwPhpz9gNBFy3zu2SCJJIZVSzn5bnmuiNqbVTbdVp2RU441Lav4+w4KIvu
XCqmEUaWn+gjvkbRX0smnIqxl5a8+akJXVXjkpwUj/hMVWIXU38rXQFEcV7O52bquNCZ840o
AAAAABcGAAEJgSgABwsBAAEjAwEBBV0AEAAADIjuCgH7rd3eAAA=
--------------3B68743274E29E999A7F8554--

--------------ms070600080708010209040409
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
EFowggUSMIID+qADAgECAgkA4wvV+K8l2YEwDQYJKoZIhvcNAQELBQAwgYIxCzAJBgNVBAYT
AkRFMSswKQYDVQQKDCJULVN5c3RlbXMgRW50ZXJwcmlzZSBTZXJ2aWNlcyBHbWJIMR8wHQYD
VQQLDBZULVN5c3RlbXMgVHJ1c3QgQ2VudGVyMSUwIwYDVQQDDBxULVRlbGVTZWMgR2xvYmFs
Um9vdCBDbGFzcyAyMB4XDTE2MDIyMjEzMzgyMloXDTMxMDIyMjIzNTk1OVowgZUxCzAJBgNV
BAYTAkRFMUUwQwYDVQQKEzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1dHNjaGVu
IEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNVBAMTJERG
Ti1WZXJlaW4gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgMjCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBAMtg1/9moUHN0vqHl4pzq5lN6mc5WqFggEcVToyVsuXPztNXS43O+FZs
FVV2B+pG/cgDRWM+cNSrVICxI5y+NyipCf8FXRgPxJiZN7Mg9mZ4F4fCnQ7MSjLnFp2uDo0p
eQcAIFTcFV9Kltd4tjTTwXS1nem/wHdN6r1ZB+BaL2w8pQDcNb1lDY9/Mm3yWmpLYgHurDg0
WUU2SQXaeMpqbVvAgWsRzNI8qIv4cRrKO+KA3Ra0Z3qLNupOkSk9s1FcragMvp0049ENF4N1
xDkesJQLEvHVaY4l9Lg9K7/AjsMeO6W/VRCrKq4Xl14zzsjz9AkH4wKGMUZrAcUQDBHHWekC
AwEAAaOCAXQwggFwMA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4EFgQUk+PYMiba1fFKpZFK4OpL
4qIMz+EwHwYDVR0jBBgwFoAUv1kgNgB5oKAia4zV8mHSuCzLgkowEgYDVR0TAQH/BAgwBgEB
/wIBAjAzBgNVHSAELDAqMA8GDSsGAQQBga0hgiwBAQQwDQYLKwYBBAGBrSGCLB4wCAYGZ4EM
AQICMEwGA1UdHwRFMEMwQaA/oD2GO2h0dHA6Ly9wa2kwMzM2LnRlbGVzZWMuZGUvcmwvVGVs
ZVNlY19HbG9iYWxSb290X0NsYXNzXzIuY3JsMIGGBggrBgEFBQcBAQR6MHgwLAYIKwYBBQUH
MAGGIGh0dHA6Ly9vY3NwMDMzNi50ZWxlc2VjLmRlL29jc3ByMEgGCCsGAQUFBzAChjxodHRw
Oi8vcGtpMDMzNi50ZWxlc2VjLmRlL2NydC9UZWxlU2VjX0dsb2JhbFJvb3RfQ2xhc3NfMi5j
ZXIwDQYJKoZIhvcNAQELBQADggEBAIcL/z4Cm2XIVi3WO5qYi3FP2ropqiH5Ri71sqQPrhE4
eTizDnS6dl2e6BiClmLbTDPo3flq3zK9LExHYFV/53RrtCyD2HlrtrdNUAtmB7Xts5et6u5/
MOaZ/SLick0+hFvu+c+Z6n/XUjkurJgARH5pO7917tALOxrN5fcPImxHhPalR6D90Bo0fa3S
PXez7vTXTf/D6OWST1k+kEcQSrCFWMBvf/iu7QhCnh7U3xQuTY+8npTD5+32GPg8SecmqKc2
2CzeIs2LgtjZeOJVEqM7h0S2EQvVDFKvaYwPBt/QolOLV5h7z/0HJPT8vcP9SpIClxvyt7bP
ZYoaorVyGTkwggWNMIIEdaADAgECAgwcOtRQhH7u81j4jncwDQYJKoZIhvcNAQELBQAwgZUx
CzAJBgNVBAYTAkRFMUUwQwYDVQQKEzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1
dHNjaGVuIEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNV
BAMTJERGTi1WZXJlaW4gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgMjAeFw0xNjExMDMxNTI0
NDhaFw0zMTAyMjIyMzU5NTlaMGoxCzAJBgNVBAYTAkRFMQ8wDQYDVQQIDAZCYXllcm4xETAP
BgNVBAcMCE11ZW5jaGVuMSAwHgYDVQQKDBdNYXgtUGxhbmNrLUdlc2VsbHNjaGFmdDEVMBMG
A1UEAwwMTVBHIENBIC0gRzAyMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAnhx4
59Lh4WqgOs/Md04XxU2yFtfM15ZuJV0PZP7BmqSJKLLPyqmOrADfNdJ5PIGBto2JBhtRRBHd
G0GROOvTRHjzOga95WOTeura79T21FWwwAwa29OFnD3ZplQs6HgdwQrZWNi1WHNJxn/4mA19
rNEBUc5urSIpZPvZi5XmlF3v3JHOlx3KWV7mUteB4pwEEfGTg4npPAJbp2o7arxQdoIq+Pu2
OsvqhD7Rk4QeaX+EM1QS4lqd1otW4hE70h/ODPy1xffgbZiuotWQLC6nIwa65Qv6byqlIX0q
Zuu99Vsu+r3sWYsL5SBkgecNI7fMJ5tfHrjoxfrKl/ErTAt8GQIDAQABo4ICBTCCAgEwEgYD
VR0TAQH/BAgwBgEB/wIBATAOBgNVHQ8BAf8EBAMCAQYwKQYDVR0gBCIwIDANBgsrBgEEAYGt
IYIsHjAPBg0rBgEEAYGtIYIsAQEEMB0GA1UdDgQWBBTEiKUH7rh7qgwTv9opdGNSG0lwFjAf
BgNVHSMEGDAWgBST49gyJtrV8UqlkUrg6kviogzP4TCBjwYDVR0fBIGHMIGEMECgPqA8hjpo
dHRwOi8vY2RwMS5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1Yi9jcmwvY2Fjcmwu
Y3JsMECgPqA8hjpodHRwOi8vY2RwMi5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1
Yi9jcmwvY2FjcmwuY3JsMIHdBggrBgEFBQcBAQSB0DCBzTAzBggrBgEFBQcwAYYnaHR0cDov
L29jc3AucGNhLmRmbi5kZS9PQ1NQLVNlcnZlci9PQ1NQMEoGCCsGAQUFBzAChj5odHRwOi8v
Y2RwMS5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNy
dDBKBggrBgEFBQcwAoY+aHR0cDovL2NkcDIucGNhLmRmbi5kZS9nbG9iYWwtcm9vdC1nMi1j
YS9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwDQYJKoZIhvcNAQELBQADggEBABLpeD5FygzqOjj+
/lAOy20UQOGWlx0RMuPcI4nuyFT8SGmK9lD7QCg/HoaJlfU/r78ex+SEide326evlFAoJXIF
jVyzNltDhpMKrPIDuh2N12zyn1EtagqPL6hu4pVRzcBpl/F2HCvtmMx5K4WN1L1fmHWLcSap
dhXLvAZ9RG/B3rqyULLSNN8xHXYXpmtvG0VGJAndZ+lj+BH7uvd3nHWnXEHC2q7iQlDUqg0a
wIqWJgdLlx1Q8Dg/sodv0m+LN0kOzGvVDRCmowBdWGhhusD+duKV66pBl+qhC+4LipariWaM
qK5ppMQROATjYeNRvwI+nDcEXr2vDaKmdbxgDVwwggWvMIIEl6ADAgECAgweKlJIhfynPMVG
/KIwDQYJKoZIhvcNAQELBQAwajELMAkGA1UEBhMCREUxDzANBgNVBAgMBkJheWVybjERMA8G
A1UEBwwITXVlbmNoZW4xIDAeBgNVBAoMF01heC1QbGFuY2stR2VzZWxsc2NoYWZ0MRUwEwYD
VQQDDAxNUEcgQ0EgLSBHMDIwHhcNMTcxMTE0MTEzNDE2WhcNMjAxMTEzMTEzNDE2WjCBizEL
MAkGA1UEBhMCREUxIDAeBgNVBAoMF01heC1QbGFuY2stR2VzZWxsc2NoYWZ0MTQwMgYDVQQL
DCtNYXgtUGxhbmNrLUluc3RpdHV0IGZ1ZXIgbW9sZWt1bGFyZSBHZW5ldGlrMQ4wDAYDVQQL
DAVNUElNRzEUMBIGA1UEAwwLUGF1bCBNZW56ZWwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw
ggEKAoIBAQDIh/UR/AX/YQ48VWWDMLTYtXjYJyhRHMc81ZHMMoaoG66lWB9MtKRTnB5lovLZ
enTIUyPsCrMhTqV9CWzDf6v9gOTWVxHEYqrUwK5H1gx4XoK81nfV8oGV4EKuVmmikTXiztGz
peyDmOY8o/EFNWP7YuRkY/lPQJQBeBHYq9AYIgX4StuXu83nusq4MDydygVOeZC15ts0tv3/
6WmibmZd1OZRqxDOkoBbY3Djx6lERohs3IKS6RKiI7e90rCSy9rtidJBOvaQS9wvtOSKPx0a
+2pAgJEVzZFjOAfBcXydXtqXhcpOi2VCyl+7+LnnTz016JJLsCBuWEcB3kP9nJYNAgMBAAGj
ggIxMIICLTAJBgNVHRMEAjAAMA4GA1UdDwEB/wQEAwIF4DAdBgNVHSUEFjAUBggrBgEFBQcD
AgYIKwYBBQUHAwQwHQYDVR0OBBYEFHM0Mc3XjMLlhWpp4JufRELL4A/qMB8GA1UdIwQYMBaA
FMSIpQfuuHuqDBO/2il0Y1IbSXAWMCAGA1UdEQQZMBeBFXBtZW56ZWxAbW9sZ2VuLm1wZy5k
ZTB9BgNVHR8EdjB0MDigNqA0hjJodHRwOi8vY2RwMS5wY2EuZGZuLmRlL21wZy1nMi1jYS9w
dWIvY3JsL2NhY3JsLmNybDA4oDagNIYyaHR0cDovL2NkcDIucGNhLmRmbi5kZS9tcGctZzIt
Y2EvcHViL2NybC9jYWNybC5jcmwwgc0GCCsGAQUFBwEBBIHAMIG9MDMGCCsGAQUFBzABhido
dHRwOi8vb2NzcC5wY2EuZGZuLmRlL09DU1AtU2VydmVyL09DU1AwQgYIKwYBBQUHMAKGNmh0
dHA6Ly9jZHAxLnBjYS5kZm4uZGUvbXBnLWcyLWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNydDBC
BggrBgEFBQcwAoY2aHR0cDovL2NkcDIucGNhLmRmbi5kZS9tcGctZzItY2EvcHViL2NhY2Vy
dC9jYWNlcnQuY3J0MEAGA1UdIAQ5MDcwDwYNKwYBBAGBrSGCLAEBBDARBg8rBgEEAYGtIYIs
AQEEAwYwEQYPKwYBBAGBrSGCLAIBBAMGMA0GCSqGSIb3DQEBCwUAA4IBAQCQs6bUDROpFO2F
Qz2FMgrdb39VEo8P3DhmpqkaIMC5ZurGbbAL/tAR6lpe4af682nEOJ7VW86ilsIJgm1j0ueY
aOuL8jrN4X7IF/8KdZnnNnImW3QVni6TCcc+7+ggci9JHtt0IDCj5vPJBpP/dKXLCN4M+exl
GXYpfHgxh8gclJPY1rquhQrihCzHfKB01w9h9tWZDVMtSoy9EUJFhCXw7mYUsvBeJwZesN2B
fndPkrXx6XWDdU3S1LyKgHlLIFtarLFm2Hb5zAUR33h+26cN6ohcGqGEEzgIG8tXS8gztEaj
1s2RyzmKd4SXTkKR3GhkZNVWy+gM68J7jP6zzN+cMYIDmjCCA5YCAQEwejBqMQswCQYDVQQG
EwJERTEPMA0GA1UECAwGQmF5ZXJuMREwDwYDVQQHDAhNdWVuY2hlbjEgMB4GA1UECgwXTWF4
LVBsYW5jay1HZXNlbGxzY2hhZnQxFTATBgNVBAMMDE1QRyBDQSAtIEcwMgIMHipSSIX8pzzF
RvyiMA0GCWCGSAFlAwQCAQUAoIIB8TAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqG
SIb3DQEJBTEPFw0xODA3MTgxNjM3NDZaMC8GCSqGSIb3DQEJBDEiBCCHwa390TJdIzcgTx4y
4mEw3kfqf4JPmQhzpaAC7ZrJNzBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcG
BSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGJBgkrBgEEAYI3EAQxfDB6MGoxCzAJBgNVBAYTAkRF
MQ8wDQYDVQQIDAZCYXllcm4xETAPBgNVBAcMCE11ZW5jaGVuMSAwHgYDVQQKDBdNYXgtUGxh
bmNrLUdlc2VsbHNjaGFmdDEVMBMGA1UEAwwMTVBHIENBIC0gRzAyAgweKlJIhfynPMVG/KIw
gYsGCyqGSIb3DQEJEAILMXygejBqMQswCQYDVQQGEwJERTEPMA0GA1UECAwGQmF5ZXJuMREw
DwYDVQQHDAhNdWVuY2hlbjEgMB4GA1UECgwXTWF4LVBsYW5jay1HZXNlbGxzY2hhZnQxFTAT
BgNVBAMMDE1QRyBDQSAtIEcwMgIMHipSSIX8pzzFRvyiMA0GCSqGSIb3DQEBAQUABIIBAKFJ
MVHWKEzj2x++COFLzkNqLkVxBO2LvWaVHuCUnel+qz2T7jUsTEsDBuyN+IvT29pZdAiDQ5Fc
R/1ue1Eqy6s2Hi2w/axngNbdL60CuogZE3CMYZkXcCgralQRVjB5HN0sRAfp9IrnvaRSwchA
ldyAorITddonKEGrHcHLroxFzSOjMC61xH8rvWCM8eHhcM8I/d4+Qfai23WrIbr8/aCmjkgD
ycm+MWKw7+CR7R7KTOYUSAMr8xxT1mG5qqY9oZsw7Tt/KJGIfg4kqIvdv739xPEqnLrXDPqc
W8Yik0ChGXGWFrrtNpN3ZXXkqI3jbpYaGjNY9ovxu3tNTJmrmPEAAAAAAAA=
--------------ms070600080708010209040409--
