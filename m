Return-Path: <kallol@nucleodyne.in>
Return-Path: <kallol@nucleodyne.in>
MIME-Version: 1.0
Sender: kallol@nucleodyne.in
In-Reply-To: <20160815172427.GA9790@localhost>
References: <CAH=XD5_kqkw=f1g_M69eUHsSDhry32s5VQJXC-_iVa+LZ+vUDA@mail.gmail.com>
 <CAH=XD58J+Yf-Rdz_bAJ-e9rU4ipu9opieFd0BuHeYAdX0nmrzg@mail.gmail.com>
 <CAH=XD59zixa7yoV7v0MUWAq-2ESCFmQZaSS89boJUYTy9wfgdw@mail.gmail.com> <20160815172427.GA9790@localhost>
From: Kallol Biswas <kallol@nucleodyne.com>
Date: Mon, 15 Aug 2016 11:39:56 -0700
Message-ID: <CAH=XD59GxwKnMp4uFfZpXB12rQtes0TFFshm1HgXLc3uMLQUVg@mail.gmail.com>
Subject: Re: Fwd: PCIe root port programming
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Content-Type: multipart/mixed; boundary=001a114b32ae121b1b053a208ff4
List-ID: <linux-pci.vger.kernel.org>

--001a114b32ae121b1b053a208ff4
Content-Type: text/plain; charset=UTF-8

Thank you for the explanation.


Here is the relevant dmesg content:

[    0.790457] PCI: root bus ff: using default resources
[    0.790491] PCI host bridge to bus 0000:ff
[    0.790493] pci_bus 0000:ff: root bus resource [io  0x0000-0xffff]
[    0.790495] pci_bus 0000:ff: root bus resource [mem
0x00000000-0x3fffffffffff]
[    0.790497] pci_bus 0000:ff: root bus resource [bus ff]

  0.795379] PCI host bridge to bus 0000:7f
[    0.795381] pci_bus 0000:7f: root bus resource [io  0x0000-0xffff]
[    0.795383] pci_bus 0000:7f: root bus resource [mem
0x00000000-0x3fffffffffff]
[    0.795384] pci_bus 0000:7f: root bus resource [bus 7f]

 0.809149] PCI host bridge to bus 0000:00
[    0.809151] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.809153] pci_bus 0000:00: root bus resource [mem
0x00000000-0x3fffffffffff]
[    0.809155] pci_bus 0000:00: root bus resource [bus 00-7e]

[    0.852071] PCI host bridge to bus 0000:80
[    0.852073] pci_bus 0000:80: root bus resource [io  0x0000-0xffff]
[    0.852075] pci_bus 0000:80: root bus resource [mem
0x00000000-0x3fffffffffff]
[    0.852077] pci_bus 0000:80: root bus resource [bus 80-fe]

Following lines are from output of /proc/iomem

c8000000-c8000000 : <BAD>
c8000001-c8000001 : <BAD>
c8000002-c8000002 : <BAD>
c8000003-c8000003 : <BAD>
c8100000-c91fffff : PCI Bus 0000:02
  c8100000-c90fffff : PCI Bus 0000:03
    c8100000-c90fffff : PCI Bus 0000:04
      c8100000-c82fffff : PCI Bus 0000:05
        c8100000-c81fffff : PCI Bus 0000:06
          c8100000-c8100fff : 0000:06:00.0
        c8200000-c82fffff : PCI Bus 0000:0a
          c8200000-c8203fff : 0000:0a:00.0
  c9100000-c913ffff : 0000:02:00.0
fb000000-fb8fffff : PCI Bus 0000:81
  fb000000-fb8fffff : PCI Bus 0000:82
    fb000000-fb7fffff : PCI Bus 0000:8c
      fb000000-fb7fffff : 0000:8c:00.0
        fb000000-fb7fffff : Plx_Mgr
    fb800000-fb8fffff : PCI Bus 0000:87
      fb800000-fb800fff : 0000:87:00.0
fb900000-fb900fff : 0000:80:05.4


I can read the device BAR via fb800000-fb800fff : 0000:87:00.0. This
device is available after reboot, and initial PCIe bus enumeration
time.

The device c8100000-c8100fff : 0000:06:00.0 shows up after a hotplug
operation is done.

Attached is the complete /proc/iomem and do not find the line
c8100000-c9ffffff : PCI Bus 0000:00, but does it exist for
PCI Bus 0000:80? BAR access works fine through this bus.



On Mon, Aug 15, 2016 at 10:24 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> Hi Kallol,
>
> Sorry I didn't respond to this earlier; I was on vacation for most of
> last week.
>
> On Fri, Aug 12, 2016 at 02:14:59PM -0700, Kallol Biswas wrote:
>>    I am trying to debug an issue that the PCIe memory
>> transactions are not routed through a host bridge.
>>
>> The config transactions work fine. The primary, secondary and
>> subordinate bus numbers look fine for the PCIe tree under the host
>> bridge. The memory windows are programmed fine.
>>
>> Can someone point me to the code that programs the chipset/root port
>> registers those direct processor transactions to a specific host
>> bridge?
>
> It looks like you have an x86 system with ACPI.  In that case, we use
> the ACPI pci_root.c host bridge driver.  The chipset configuration for
> routing processor memory transactions to host bridges is done by the
> firmware, and the kernel doesn't touch it.  There should be
> information in the chipset spec about how to do this, but there's no
> code in Linux itself that does it.
>
>> Cat of /proc/mem is copied below.
>>
>> /root/physmem -p c8100000 -s 4 -r
>> Operation:read to Addr: 0xc8100000 Value: 0
>> ffffffff ffffffff ffffffff ffffffff
>>
>> The PCIe analyzer sitting between host bridge (0:3.0 and 02:00.0) and
>> external switches/devices does not capture any mem transactions.
>> However, config transactions are visible in the trace.
>
> 00:03.0 is not a host bridge; it's a Root Port, which logically
> connects two PCI buses.  A host bridge logically connects a processor
> bus to a PCI bus.
>
>> root@xlink-target:~# cat /proc/iomem
>> 00000000-00000fff : reserved
>> 00001000-0009abff : System RAM
>> 0009ac00-0009ffff : reserved
>> 000c0000-000c7fff : Video ROM
>> 000c8000-000c8fff : Adapter ROM
>> 000e0000-000fffff : reserved
>>   000f0000-000fffff : System ROM
>> 00100000-78f36fff : System RAM
>>   01000000-01828f14 : Kernel code
>>   01828f15-01f3fb3f : Kernel data
>>   020bb000-021fdfff : Kernel bss
>>   30000000-37ffffff : Crash kernel
>> 78f37000-79839fff : reserved
>>   79116018-79116018 : APEI ERST
>>   7911601c-79116021 : APEI ERST
>>   79116028-79116039 : APEI ERST
>>   79116040-7911604c : APEI ERST
>>   79116050-7911804f : APEI ERST
>> 7983a000-79d4afff : ACPI Non-volatile Storage
>> 79d4b000-8fffffff : reserved
>>   80000000-8fffffff : PCI MMCONFIG 0000 [bus 00-ff]
>> c6000000-c70fffff : PCI Bus 0000:2f
>>   c6000000-c70fffff : PCI Bus 0000:30
>>     c6000000-c6ffffff : 0000:30:00.0
>>     c7000000-c701ffff : 0000:30:00.0
>> c7100000-c71fffff : PCI Bus 0000:31
>>   c7100000-c711ffff : 0000:31:00.1
>>     c7100000-c711ffff : igb
>>   c7120000-c713ffff : 0000:31:00.0
>>     c7120000-c713ffff : igb
>>   c7140000-c7143fff : 0000:31:00.1
>>     c7140000-c7143fff : igb
>>   c7144000-c7147fff : 0000:31:00.0
>>     c7144000-c7147fff : igb
>> c7300000-c730ffff : 0000:00:14.0
>>   c7300000-c730ffff : xhci-hcd
>> c7310000-c73107ff : 0000:00:1f.2
>>   c7310000-c73107ff : ahci
>> c7311000-c73113ff : 0000:00:1d.0
>>   c7311000-c73113ff : ehci_hcd
>> c7312000-c73123ff : 0000:00:1a.0
>>   c7312000-c73123ff : ehci_hcd
>> c7314000-c731400f : 0000:00:16.1
>> c7315000-c731500f : 0000:00:16.0
>> c7316000-c73167ff : 0000:00:11.4
>>   c7316000-c73167ff : ahci
>> c7317000-c7317fff : 0000:00:05.4
>> c7ffc000-c7ffcfff : dmar1
>> c8000000-c8000000 : <BAD>
>> c8000001-c8000001 : <BAD>
>> c8000002-c8000002 : <BAD>
>> c8000003-c8000003 : <BAD>
>
> Interesting, what are these from?
>
>> c8100000-c91fffff : PCI Bus 0000:02
>>   c8100000-c90fffff : PCI Bus 0000:03
>>     c8100000-c90fffff : PCI Bus 0000:04
>>       c8100000-c82fffff : PCI Bus 0000:05
>>         c8100000-c81fffff : PCI Bus 0000:06
>>           c8100000-c8100fff : 0000:06:00.0
>
> You're trying to read the 06:00.0 BAR at 0xc8100000.  The windows
> above look fine, but the top-level host bridge window is missing.
>
> The c8100000-c91fffff window is a window through the 00:03.0 Root
> Port, which connects bus 00 to bus 02.  The 00:03.0 bridge forwards
> memory transactions in the c8100000-c91fffff range from its primary
> bus (bus 00) to its secondary bus (bus 02).
>
> But we don't know how those transactions get to bus 00 in the first
> place.  The host bridge is the connection between the processor and
> bus 00, and it should have a window that encloses c8100000-c91fffff.
>
> Your dmesg log should have information about this bridge, e.g.,
> something like this:
>
>   ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-7f])
>   PCI host bridge to bus 0000:00
>   pci_bus 0000:00: root bus resource [mem 0xc8100000-0xc9ffffff window]
>
> and there should be a line in /proc/iomem something like this:
>
>   c8100000-c9ffffff : PCI Bus 0000:00
>
> Bjorn

--001a114b32ae121b1b053a208ff4
Content-Type: text/plain; charset=US-ASCII; name="iomem.txt"
Content-Disposition: attachment; filename="iomem.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_irwdwj8y0

MDAwMDAwMDAtMDAwMDBmZmYgOiByZXNlcnZlZAowMDAwMTAwMC0wMDA5YWJmZiA6IFN5c3RlbSBS
QU0KMDAwOWFjMDAtMDAwOWZmZmYgOiByZXNlcnZlZAowMDBjMDAwMC0wMDBjN2ZmZiA6IFZpZGVv
IFJPTQowMDBjODAwMC0wMDBjOGZmZiA6IEFkYXB0ZXIgUk9NCjAwMGUwMDAwLTAwMGZmZmZmIDog
cmVzZXJ2ZWQKICAwMDBmMDAwMC0wMDBmZmZmZiA6IFN5c3RlbSBST00KMDAxMDAwMDAtNzhmMzZm
ZmYgOiBTeXN0ZW0gUkFNCiAgMDEwMDAwMDAtMDE4MjhmMTQgOiBLZXJuZWwgY29kZQogIDAxODI4
ZjE1LTAxZjNmYjNmIDogS2VybmVsIGRhdGEKICAwMjBiYjAwMC0wMjFmZGZmZiA6IEtlcm5lbCBi
c3MKICAzMDAwMDAwMC0zN2ZmZmZmZiA6IENyYXNoIGtlcm5lbAo3OGYzNzAwMC03OTgzOWZmZiA6
IHJlc2VydmVkCiAgNzkxMTYwMTgtNzkxMTYwMTggOiBBUEVJIEVSU1QKICA3OTExNjAxYy03OTEx
NjAyMSA6IEFQRUkgRVJTVAogIDc5MTE2MDI4LTc5MTE2MDM5IDogQVBFSSBFUlNUCiAgNzkxMTYw
NDAtNzkxMTYwNGMgOiBBUEVJIEVSU1QKICA3OTExNjA1MC03OTExODA0ZiA6IEFQRUkgRVJTVAo3
OTgzYTAwMC03OWQ0YWZmZiA6IEFDUEkgTm9uLXZvbGF0aWxlIFN0b3JhZ2UKNzlkNGIwMDAtOGZm
ZmZmZmYgOiByZXNlcnZlZAogIDgwMDAwMDAwLThmZmZmZmZmIDogUENJIE1NQ09ORklHIDAwMDAg
W2J1cyAwMC1mZl0KYzYwMDAwMDAtYzcwZmZmZmYgOiBQQ0kgQnVzIDAwMDA6MmYKICBjNjAwMDAw
MC1jNzBmZmZmZiA6IFBDSSBCdXMgMDAwMDozMAogICAgYzYwMDAwMDAtYzZmZmZmZmYgOiAwMDAw
OjMwOjAwLjAKICAgIGM3MDAwMDAwLWM3MDFmZmZmIDogMDAwMDozMDowMC4wCmM3MTAwMDAwLWM3
MWZmZmZmIDogUENJIEJ1cyAwMDAwOjMxCiAgYzcxMDAwMDAtYzcxMWZmZmYgOiAwMDAwOjMxOjAw
LjEKICAgIGM3MTAwMDAwLWM3MTFmZmZmIDogaWdiCiAgYzcxMjAwMDAtYzcxM2ZmZmYgOiAwMDAw
OjMxOjAwLjAKICAgIGM3MTIwMDAwLWM3MTNmZmZmIDogaWdiCiAgYzcxNDAwMDAtYzcxNDNmZmYg
OiAwMDAwOjMxOjAwLjEKICAgIGM3MTQwMDAwLWM3MTQzZmZmIDogaWdiCiAgYzcxNDQwMDAtYzcx
NDdmZmYgOiAwMDAwOjMxOjAwLjAKICAgIGM3MTQ0MDAwLWM3MTQ3ZmZmIDogaWdiCmM3MzAwMDAw
LWM3MzBmZmZmIDogMDAwMDowMDoxNC4wCiAgYzczMDAwMDAtYzczMGZmZmYgOiB4aGNpLWhjZApj
NzMxMDAwMC1jNzMxMDdmZiA6IDAwMDA6MDA6MWYuMgogIGM3MzEwMDAwLWM3MzEwN2ZmIDogYWhj
aQpjNzMxMTAwMC1jNzMxMTNmZiA6IDAwMDA6MDA6MWQuMAogIGM3MzExMDAwLWM3MzExM2ZmIDog
ZWhjaV9oY2QKYzczMTIwMDAtYzczMTIzZmYgOiAwMDAwOjAwOjFhLjAKICBjNzMxMjAwMC1jNzMx
MjNmZiA6IGVoY2lfaGNkCmM3MzE0MDAwLWM3MzE0MDBmIDogMDAwMDowMDoxNi4xCmM3MzE1MDAw
LWM3MzE1MDBmIDogMDAwMDowMDoxNi4wCmM3MzE2MDAwLWM3MzE2N2ZmIDogMDAwMDowMDoxMS40
CiAgYzczMTYwMDAtYzczMTY3ZmYgOiBhaGNpCmM3MzE3MDAwLWM3MzE3ZmZmIDogMDAwMDowMDow
NS40CmM3ZmZjMDAwLWM3ZmZjZmZmIDogZG1hcjEKYzgwMDAwMDAtYzgwMDAwMDAgOiA8QkFEPgpj
ODAwMDAwMS1jODAwMDAwMSA6IDxCQUQ+CmM4MDAwMDAyLWM4MDAwMDAyIDogPEJBRD4KYzgwMDAw
MDMtYzgwMDAwMDMgOiA8QkFEPgpjODEwMDAwMC1jOTFmZmZmZiA6IFBDSSBCdXMgMDAwMDowMgog
IGM4MTAwMDAwLWM5MGZmZmZmIDogUENJIEJ1cyAwMDAwOjAzCiAgICBjODEwMDAwMC1jOTBmZmZm
ZiA6IFBDSSBCdXMgMDAwMDowNAogICAgICBjODEwMDAwMC1jODJmZmZmZiA6IFBDSSBCdXMgMDAw
MDowNQogICAgICAgIGM4MTAwMDAwLWM4MWZmZmZmIDogUENJIEJ1cyAwMDAwOjA2CiAgICAgICAg
ICBjODEwMDAwMC1jODEwMGZmZiA6IDAwMDA6MDY6MDAuMAogICAgICAgIGM4MjAwMDAwLWM4MmZm
ZmZmIDogUENJIEJ1cyAwMDAwOjBhCiAgICAgICAgICBjODIwMDAwMC1jODIwM2ZmZiA6IDAwMDA6
MGE6MDAuMAogIGM5MTAwMDAwLWM5MTNmZmZmIDogMDAwMDowMjowMC4wCmZiMDAwMDAwLWZiOGZm
ZmZmIDogUENJIEJ1cyAwMDAwOjgxCiAgZmIwMDAwMDAtZmI4ZmZmZmYgOiBQQ0kgQnVzIDAwMDA6
ODIKICAgIGZiMDAwMDAwLWZiN2ZmZmZmIDogUENJIEJ1cyAwMDAwOjhjCiAgICAgIGZiMDAwMDAw
LWZiN2ZmZmZmIDogMDAwMDo4YzowMC4wCiAgICAgICAgZmIwMDAwMDAtZmI3ZmZmZmYgOiBQbHhf
TWdyCiAgICBmYjgwMDAwMC1mYjhmZmZmZiA6IFBDSSBCdXMgMDAwMDo4NwogICAgICBmYjgwMDAw
MC1mYjgwMGZmZiA6IDAwMDA6ODc6MDAuMApmYjkwMDAwMC1mYjkwMGZmZiA6IDAwMDA6ODA6MDUu
NApmYmZmYzAwMC1mYmZmY2ZmZiA6IGRtYXIwCmZlYzAwMDAwLWZlY2ZmZmZmIDogUE5QMDAwMzow
MAogIGZlYzAwMDAwLWZlYzAwM2ZmIDogSU9BUElDIDAKICBmZWMwMTAwMC1mZWMwMTNmZiA6IElP
QVBJQyAxCiAgZmVjNDAwMDAtZmVjNDAzZmYgOiBJT0FQSUMgMgpmZWQwMDAwMC1mZWQwMDNmZiA6
IEhQRVQgMAogIGZlZDAwMDAwLWZlZDAwM2ZmIDogUE5QMDEwMzowMApmZWQxMjAwMC1mZWQxMjAw
ZiA6IHBucCAwMDowMQpmZWQxMjAxMC1mZWQxMjAxZiA6IHBucCAwMDowMQpmZWQxYjAwMC1mZWQx
YmZmZiA6IHBucCAwMDowMQpmZWQxYzAwMC1mZWQ0NGZmZiA6IHJlc2VydmVkCiAgZmVkMWMwMDAt
ZmVkM2ZmZmYgOiBwbnAgMDA6MDEKICAgIGZlZDFmNDEwLWZlZDFmNDE0IDogaVRDT193ZHQuMC5h
dXRvCmZlZDQ1MDAwLWZlZDhiZmZmIDogcG5wIDAwOjAxCmZlZTAwMDAwLWZlZWZmZmZmIDogcG5w
IDAwOjAxCiAgZmVlMDAwMDAtZmVlMDBmZmYgOiBMb2NhbCBBUElDCmZmMDAwMDAwLWZmZmZmZmZm
IDogcmVzZXJ2ZWQKICBmZjAwMDAwMC1mZmZmZmZmZiA6IHBucCAwMDowMQoxMDAwMDAwMDAtNDdm
ZmZmZmZmIDogU3lzdGVtIFJBTQo0ODAwMDAwMDAtNDgwN2ZmZmZmIDogUENJIEJ1cyAwMDAwOjAy
CiAgNDgwMDAwMDAwLTQ4MDdmZmZmZiA6IFBDSSBCdXMgMDAwMDowMwogICAgNDgwMDAwMDAwLTQ4
MDdmZmZmZiA6IFBDSSBCdXMgMDAwMDowNAogICAgICA0ODAwMDAwMDAtNDgwMGZmZmZmIDogUENJ
IEJ1cyAwMDAwOjA1CiAgICAgICAgNDgwMDAwMDAwLTQ4MDBmZmZmZiA6IFBDSSBCdXMgMDAwMDow
NgogICAgICAgICAgNDgwMDAwMDAwLTQ4MDAwM2ZmZiA6IDAwMDA6MDY6MDAuMAozODNmZmZlMDAw
MDAtMzgzZmZmZWZmZmZmIDogUENJIEJ1cyAwMDAwOjMxCiAgMzgzZmZmZTAwMDAwLTM4M2ZmZmUx
ZmZmZiA6IDAwMDA6MzE6MDAuMQogIDM4M2ZmZmUyMDAwMC0zODNmZmZlM2ZmZmYgOiAwMDAwOjMx
OjAwLjEKICAzODNmZmZlNDAwMDAtMzgzZmZmZTVmZmZmIDogMDAwMDozMTowMC4wCiAgMzgzZmZm
ZTYwMDAwLTM4M2ZmZmU3ZmZmZiA6IDAwMDA6MzE6MDAuMAozODNmZmZmMDAwMDAtMzgzZmZmZjAz
ZmZmIDogMDAwMDowMDowNC43CiAgMzgzZmZmZjAwMDAwLTM4M2ZmZmYwM2ZmZiA6IGlvYXRkbWEK
MzgzZmZmZjA0MDAwLTM4M2ZmZmYwN2ZmZiA6IDAwMDA6MDA6MDQuNgogIDM4M2ZmZmYwNDAwMC0z
ODNmZmZmMDdmZmYgOiBpb2F0ZG1hCjM4M2ZmZmYwODAwMC0zODNmZmZmMGJmZmYgOiAwMDAwOjAw
OjA0LjUKICAzODNmZmZmMDgwMDAtMzgzZmZmZjBiZmZmIDogaW9hdGRtYQozODNmZmZmMGMwMDAt
MzgzZmZmZjBmZmZmIDogMDAwMDowMDowNC40CiAgMzgzZmZmZjBjMDAwLTM4M2ZmZmYwZmZmZiA6
IGlvYXRkbWEKMzgzZmZmZjEwMDAwLTM4M2ZmZmYxM2ZmZiA6IDAwMDA6MDA6MDQuMwogIDM4M2Zm
ZmYxMDAwMC0zODNmZmZmMTNmZmYgOiBpb2F0ZG1hCjM4M2ZmZmYxNDAwMC0zODNmZmZmMTdmZmYg
OiAwMDAwOjAwOjA0LjIKICAzODNmZmZmMTQwMDAtMzgzZmZmZjE3ZmZmIDogaW9hdGRtYQozODNm
ZmZmMTgwMDAtMzgzZmZmZjFiZmZmIDogMDAwMDowMDowNC4xCiAgMzgzZmZmZjE4MDAwLTM4M2Zm
ZmYxYmZmZiA6IGlvYXRkbWEKMzgzZmZmZjFjMDAwLTM4M2ZmZmYxZmZmZiA6IDAwMDA6MDA6MDQu
MAogIDM4M2ZmZmYxYzAwMC0zODNmZmZmMWZmZmYgOiBpb2F0ZG1hCjM4M2ZmZmYyMTAwMC0zODNm
ZmZmMjEwZmYgOiAwMDAwOjAwOjFmLjMKMzg3ZmZmZTAwMDAwLTM4N2ZmZmVmZmZmZiA6IFBDSSBC
dXMgMDAwMDo4MQogIDM4N2ZmZmUwMDAwMC0zODdmZmZlZmZmZmYgOiBQQ0kgQnVzIDAwMDA6ODIK
ICAgIDM4N2ZmZmUwMDAwMC0zODdmZmZlZmZmZmYgOiBQQ0kgQnVzIDAwMDA6ODcKICAgICAgMzg3
ZmZmZTAwMDAwLTM4N2ZmZmUwM2ZmZiA6IDAwMDA6ODc6MDAuMAozODdmZmZmMDAwMDAtMzg3ZmZm
ZjAzZmZmIDogMDAwMDo4MDowNC43CiAgMzg3ZmZmZjAwMDAwLTM4N2ZmZmYwM2ZmZiA6IGlvYXRk
bWEKMzg3ZmZmZjA0MDAwLTM4N2ZmZmYwN2ZmZiA6IDAwMDA6ODA6MDQuNgogIDM4N2ZmZmYwNDAw
MC0zODdmZmZmMDdmZmYgOiBpb2F0ZG1hCjM4N2ZmZmYwODAwMC0zODdmZmZmMGJmZmYgOiAwMDAw
OjgwOjA0LjUKICAzODdmZmZmMDgwMDAtMzg3ZmZmZjBiZmZmIDogaW9hdGRtYQozODdmZmZmMGMw
MDAtMzg3ZmZmZjBmZmZmIDogMDAwMDo4MDowNC40CiAgMzg3ZmZmZjBjMDAwLTM4N2ZmZmYwZmZm
ZiA6IGlvYXRkbWEKMzg3ZmZmZjEwMDAwLTM4N2ZmZmYxM2ZmZiA6IDAwMDA6ODA6MDQuMwogIDM4
N2ZmZmYxMDAwMC0zODdmZmZmMTNmZmYgOiBpb2F0ZG1hCjM4N2ZmZmYxNDAwMC0zODdmZmZmMTdm
ZmYgOiAwMDAwOjgwOjA0LjIKICAzODdmZmZmMTQwMDAtMzg3ZmZmZjE3ZmZmIDogaW9hdGRtYQoz
ODdmZmZmMTgwMDAtMzg3ZmZmZjFiZmZmIDogMDAwMDo4MDowNC4xCiAgMzg3ZmZmZjE4MDAwLTM4
N2ZmZmYxYmZmZiA6IGlvYXRkbWEKMzg3ZmZmZjFjMDAwLTM4N2ZmZmYxZmZmZiA6IDAwMDA6ODA6
MDQuMAogIDM4N2ZmZmYxYzAwMC0zODdmZmZmMWZmZmYgOiBpb2F0ZG1hCg==
--001a114b32ae121b1b053a208ff4--
