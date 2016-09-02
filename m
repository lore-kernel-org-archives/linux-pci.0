Return-Path: <briannorris@chromium.org>
Return-Path: <briannorris@chromium.org>
MIME-Version: 1.0
In-Reply-To: <20160902154409.GA8370@localhost>
References: <1471570498-3284-1-git-send-email-shawn.lin@rock-chips.com>
 <20160831181754.GA7460@roeck-us.net> <9075a2c1-c787-986f-31b4-4d5b7c92b771@rock-chips.com>
 <20160901163455.GA9471@localhost> <20160901171400.GA4093@localhost>
 <20160901174852.GC9471@localhost> <20160902154409.GA8370@localhost>
From: Brian Norris <briannorris@chromium.org>
Date: Fri, 2 Sep 2016 09:18:01 -0700
Message-ID: <CA+ASDXPRs_cfAU7qae7r26XJRSEsDghbocD8DL4hpJjuq3aHSw@mail.gmail.com>
Subject: Re: [v10,2/2] PCI: Rockchip: Add Rockchip PCIe controller support
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Guenter Roeck <linux@roeck-us.net>,
	Bjorn Helgaas <bhelgaas@google.com>, Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	"open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Heiko Stuebner <heiko@sntech.de>,
	Doug Anderson <dianders@chromium.org>, Wenrui Li <wenrui.li@rock-chips.com>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Content-Type: multipart/alternative; boundary=94eb2c0bdd76ae339a053b88acbd
List-ID: <linux-pci.vger.kernel.org>

--94eb2c0bdd76ae339a053b88acbd
Content-Type: text/plain; charset=UTF-8

On Fri, Sep 2, 2016 at 8:44 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> Here's a second proposal.  It retains HIWORD_UPDATE (though the structure
> is different) so grep finds it along with the other Rockchip ones.
>
> I'll post updated actual patches; this is just to give the idea:
>
> -/*
> -  * The higher 16-bit of this register is used for write protection
> -  * only if BIT(x + 16) set to 1 the BIT(x) can be written.
> -  */
> -#define HIWORD_UPDATE(val, mask, shift) \
> -       ((val) << (shift) | (mask) << ((shift) + 16))
>
> -#define PCIE_CLIENT_CONF_ENABLE                        BIT(0)
> -#define PCIE_CLIENT_CONF_ENABLE_SHIFT          0
> -#define PCIE_CLIENT_CONF_ENABLE_MASK           0x1
> -#define PCIE_CLIENT_LINK_TRAIN_ENABLE          1
> -#define PCIE_CLIENT_LINK_TRAIN_SHIFT           1
> -#define PCIE_CLIENT_LINK_TRAIN_MASK            0x1
> -#define PCIE_CLIENT_ARI_ENABLE                 BIT(0)
> -#define PCIE_CLIENT_ARI_ENABLE_SHIFT           3
> -#define PCIE_CLIENT_ARI_ENABLE_MASK            0x1
> -#define PCIE_CLIENT_CONF_LANE_NUM(x)           (x / 2)
> -#define PCIE_CLIENT_CONF_LANE_NUM_SHIFT                4
> -#define PCIE_CLIENT_CONF_LANE_NUM_MASK         0x3
> -#define PCIE_CLIENT_MODE_RC                    BIT(0)
> -#define PCIE_CLIENT_MODE_SHIFT                 6
> -#define PCIE_CLIENT_MODE_MASK                  0x1
> -#define PCIE_CLIENT_GEN_SEL_2                  1
> -#define PCIE_CLIENT_GEN_SEL_SHIFT              7
> -#define PCIE_CLIENT_GEN_SEL_MASK               0x1
>
> +/*
> + * The upper 16 bits of the PCIE_CLIENT registers are a write mask for the
> + * lower 16 bits.  This allows atomic updates of the register without
> + * locking.
> + */
> +#define HIWORD_UPDATE(mask, val)       ((mask << 16) | val)
> +
> +#define ENCODE_LANES(x)                        (((x >> 1) & 3) << 4)
> +
> +#define PCIE_CLIENT_CONF_ENABLE                HIWORD_UPDATE(0x0001,
> 0x0001)
> +#define PCIE_CLIENT_LINK_TRAIN_ENABLE  HIWORD_UPDATE(0x0002, 0x0002)
> +#define PCIE_CLIENT_CONF_LANE_NUM(x)   HIWORD_UPDATE(0x0030,
> ENCODE_LANES(x))
> +#define PCIE_CLIENT_GEN_SEL_2          HIWORD_UPDATE(0x0040, 0x0040)
>
>         rockchip_pcie_write(rockchip,
> -                  HIWORD_UPDATE(PCIE_CLIENT_CONF_ENABLE,
> -                                PCIE_CLIENT_CONF_ENABLE_MASK,
> -                                PCIE_CLIENT_CONF_ENABLE_SHIFT) |
> -                  HIWORD_UPDATE(PCIE_CLIENT_
> CONF_LANE_NUM(rockchip->lanes),
> -                                PCIE_CLIENT_CONF_LANE_NUM_MASK,
> -                                PCIE_CLIENT_CONF_LANE_NUM_SHIFT) |
> -                  HIWORD_UPDATE(PCIE_CLIENT_MODE_RC,
> -                                PCIE_CLIENT_MODE_MASK,
> -                                PCIE_CLIENT_MODE_SHIFT) |
> -                  HIWORD_UPDATE(PCIE_CLIENT_ARI_ENABLE,
> -                                PCIE_CLIENT_ARI_ENABLE_MASK,
> -                                PCIE_CLIENT_ARI_ENABLE_SHIFT) |
> -                  HIWORD_UPDATE(PCIE_CLIENT_GEN_SEL_2,
> -                                PCIE_CLIENT_GEN_SEL_MASK,
> -                                PCIE_CLIENT_GEN_SEL_SHIFT),
> -                  PCIE_CLIENT_BASE);
> +                           PCIE_CLIENT_CONF_ENABLE |
> +                           PCIE_CLIENT_LINK_TRAIN_ENABLE |
> +                           PCIE_CLIENT_ARI_ENABLE |
> +                           PCIE_CLIENT_CONF_LANE_NUM(rockchip->lanes) |
> +                           PCIE_CLIENT_MODE_RC |
> +                           PCIE_CLIENT_GEN_SEL_2,
> +                               PCIE_CLIENT_BASE);
>

That's pretty much along the lines of the compromise I was implying
earlier. Seems decent to me, for whatever my opinion's worth :)

Thanks,
Brian

--94eb2c0bdd76ae339a053b88acbd
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPjxkaXYgY2xhc3M9ImdtYWls
X3F1b3RlIj5PbiBGcmksIFNlcCAyLCAyMDE2IGF0IDg6NDQgQU0sIEJqb3JuIEhlbGdhYXMgPHNw
YW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86aGVsZ2Fhc0BrZXJuZWwub3JnIiB0YXJn
ZXQ9Il9ibGFuayI+aGVsZ2Fhc0BrZXJuZWwub3JnPC9hPiZndDs8L3NwYW4+IHdyb3RlOjxibG9j
a3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRl
ci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPkhlcmUmIzM5O3MgYSBzZWNv
bmQgcHJvcG9zYWwuwqAgSXQgcmV0YWlucyBISVdPUkRfVVBEQVRFICh0aG91Z2ggdGhlIHN0cnVj
dHVyZTxicj4NCmlzIGRpZmZlcmVudCkgc28gZ3JlcCBmaW5kcyBpdCBhbG9uZyB3aXRoIHRoZSBv
dGhlciBSb2NrY2hpcCBvbmVzLjxicj4NCjxicj4NCkkmIzM5O2xsIHBvc3QgdXBkYXRlZCBhY3R1
YWwgcGF0Y2hlczsgdGhpcyBpcyBqdXN0IHRvIGdpdmUgdGhlIGlkZWE6PGJyPg0KPHNwYW4gY2xh
c3M9IiI+PGJyPg0KLS8qPGJyPg0KLcKgICogVGhlIGhpZ2hlciAxNi1iaXQgb2YgdGhpcyByZWdp
c3RlciBpcyB1c2VkIGZvciB3cml0ZSBwcm90ZWN0aW9uPGJyPg0KLcKgICogb25seSBpZiBCSVQo
eCArIDE2KSBzZXQgdG8gMSB0aGUgQklUKHgpIGNhbiBiZSB3cml0dGVuLjxicj4NCi3CoCAqLzxi
cj4NCi0jZGVmaW5lIEhJV09SRF9VUERBVEUodmFsLCBtYXNrLCBzaGlmdCkgXDxicj4NCi3CoCDC
oCDCoCDCoCgodmFsKSAmbHQ7Jmx0OyAoc2hpZnQpIHwgKG1hc2spICZsdDsmbHQ7ICgoc2hpZnQp
ICsgMTYpKTxicj4NCjxicj4NCjwvc3Bhbj4tI2RlZmluZSBQQ0lFX0NMSUVOVF9DT05GX0VOQUJM
RcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIEJJVCgwKTxicj4NCi0jZGVmaW5l
IFBDSUVfQ0xJRU5UX0NPTkZfRU5BQkxFX1NISUZUwqAgwqAgwqAgwqAgwqAgMDxicj4NCi0jZGVm
aW5lIFBDSUVfQ0xJRU5UX0NPTkZfRU5BQkxFX01BU0vCoCDCoCDCoCDCoCDCoCDCoDB4MTxicj4N
Ci0jZGVmaW5lIFBDSUVfQ0xJRU5UX0xJTktfVFJBSU5fRU5BQkxFwqAgwqAgwqAgwqAgwqAgMTxi
cj4NCi0jZGVmaW5lIFBDSUVfQ0xJRU5UX0xJTktfVFJBSU5fU0hJRlTCoCDCoCDCoCDCoCDCoCDC
oDE8YnI+DQotI2RlZmluZSBQQ0lFX0NMSUVOVF9MSU5LX1RSQUlOX01BU0vCoCDCoCDCoCDCoCDC
oCDCoCAweDE8YnI+DQotI2RlZmluZSBQQ0lFX0NMSUVOVF9BUklfRU5BQkxFwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBCSVQoMCk8YnI+DQotI2RlZmluZSBQQ0lFX0NMSUVOVF9BUklfRU5BQkxF
X1NISUZUwqAgwqAgwqAgwqAgwqAgwqAzPGJyPg0KLSNkZWZpbmUgUENJRV9DTElFTlRfQVJJX0VO
QUJMRV9NQVNLwqAgwqAgwqAgwqAgwqAgwqAgMHgxPGJyPg0KLSNkZWZpbmUgUENJRV9DTElFTlRf
Q09ORl9MQU5FX05VTSh4KcKgIMKgIMKgIMKgIMKgIMKgKHggLyAyKTxicj4NCi0jZGVmaW5lIFBD
SUVfQ0xJRU5UX0NPTkZfTEFORV9OVU1fPHdicj5TSElGVMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IDQ8YnI+DQotI2RlZmluZSBQQ0lFX0NMSUVOVF9DT05GX0xBTkVfTlVNX01BU0vCoCDCoCDCoCDC
oCDCoDB4Mzxicj4NCi0jZGVmaW5lIFBDSUVfQ0xJRU5UX01PREVfUkPCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBCSVQoMCk8YnI+DQotI2RlZmluZSBQQ0lFX0NMSUVOVF9NT0RFX1NISUZU
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA2PGJyPg0KLSNkZWZpbmUgUENJRV9DTElFTlRfTU9E
RV9NQVNLwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgMHgxPGJyPg0KLSNkZWZpbmUgUENJRV9D
TElFTlRfR0VOX1NFTF8ywqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgMTxicj4NCi0jZGVmaW5l
IFBDSUVfQ0xJRU5UX0dFTl9TRUxfU0hJRlTCoCDCoCDCoCDCoCDCoCDCoCDCoCA3PGJyPg0KLSNk
ZWZpbmUgUENJRV9DTElFTlRfR0VOX1NFTF9NQVNLwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAweDE8
YnI+DQo8YnI+DQorLyo8YnI+DQorICogVGhlIHVwcGVyIDE2IGJpdHMgb2YgdGhlIFBDSUVfQ0xJ
RU5UIHJlZ2lzdGVycyBhcmUgYSB3cml0ZSBtYXNrIGZvciB0aGU8YnI+DQorICogbG93ZXIgMTYg
Yml0cy7CoCBUaGlzIGFsbG93cyBhdG9taWMgdXBkYXRlcyBvZiB0aGUgcmVnaXN0ZXIgd2l0aG91
dDxicj4NCisgKiBsb2NraW5nLjxicj4NCisgKi88YnI+DQorI2RlZmluZSBISVdPUkRfVVBEQVRF
KG1hc2ssIHZhbCnCoCDCoCDCoCDCoCgobWFzayAmbHQ7Jmx0OyAxNikgfCB2YWwpPGJyPg0KKzxi
cj4NCisjZGVmaW5lIEVOQ09ERV9MQU5FUyh4KcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgICgoKHggJmd0OyZndDsgMSkgJmFtcDsgMykgJmx0OyZsdDsgNCk8YnI+DQorPGJyPg0K
KyNkZWZpbmUgUENJRV9DTElFTlRfQ09ORl9FTkFCTEXCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBI
SVdPUkRfVVBEQVRFKDB4MDAwMSwgMHgwMDAxKTxicj4NCisjZGVmaW5lIFBDSUVfQ0xJRU5UX0xJ
TktfVFJBSU5fRU5BQkxFwqAgSElXT1JEX1VQREFURSgweDAwMDIsIDB4MDAwMik8YnI+DQorI2Rl
ZmluZSBQQ0lFX0NMSUVOVF9DT05GX0xBTkVfTlVNKHgpwqAgwqBISVdPUkRfVVBEQVRFKDB4MDAz
MCwgRU5DT0RFX0xBTkVTKHgpKTxicj4NCisjZGVmaW5lIFBDSUVfQ0xJRU5UX0dFTl9TRUxfMsKg
IMKgIMKgIMKgIMKgIEhJV09SRF9VUERBVEUoMHgwMDQwLCAweDAwNDApPGJyPg0KPGJyPg0KwqAg
wqAgwqAgwqAgcm9ja2NoaXBfcGNpZV93cml0ZShyb2NrY2hpcCw8YnI+DQo8c3BhbiBjbGFzcz0i
Ij4twqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgSElXT1JEX1VQREFURShQQ0lFX0NMSUVOVF88
d2JyPkNPTkZfRU5BQkxFLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBQQ0lFX0NMSUVOVF9DT05GX0VOQUJMRV9NQVNLLDxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBQQ0lFX0NMSUVOVF9DT05G
X0VOQUJMRV9TSElGVCkgfDxicj4NCjwvc3Bhbj4twqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
SElXT1JEX1VQREFURShQQ0lFX0NMSUVOVF88d2JyPkNPTkZfTEFORV9OVU0ocm9ja2NoaXAtJmd0
O2xhbmVzKTx3YnI+LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBQQ0lFX0NMSUVOVF9DT05GX0xBTkVfTlVNXzx3YnI+TUFTSyw8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgUENJRV9DTElFTlRf
Q09ORl9MQU5FX05VTV88d2JyPlNISUZUKSB8PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIEhJV09SRF9VUERBVEUoUENJRV9DTElFTlRfPHdicj5NT0RFX1JDLDxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBQQ0lFX0NMSUVOVF9NT0RF
X01BU0ssPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIFBDSUVfQ0xJRU5UX01PREVfU0hJRlQpIHw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgSElXT1JEX1VQREFURShQQ0lFX0NMSUVOVF9BUklfPHdicj5FTkFCTEUsPGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFBDSUVfQ0xJRU5U
X0FSSV9FTkFCTEVfTUFTSyw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgUENJRV9DTElFTlRfQVJJX0VOQUJMRV9TSElGVCkgfDxicj4NCi3CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBISVdPUkRfVVBEQVRFKFBDSUVfQ0xJRU5UX0dFTl88d2Jy
PlNFTF8yLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBQQ0lFX0NMSUVOVF9HRU5fU0VMX01BU0ssPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFBDSUVfQ0xJRU5UX0dFTl9TRUxfU0hJRlQpLDxi
cj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBQQ0lFX0NMSUVOVF9CQVNFKTs8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBQQ0lFX0NMSUVOVF9DT05G
X0VOQUJMRSB8PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
UENJRV9DTElFTlRfTElOS19UUkFJTl9FTkFCTEUgfDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoFBDSUVfQ0xJRU5UX0FSSV9FTkFCTEUgfDxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFBDSUVfQ0xJRU5UX0NPTkZfTEFO
RV9OVU0oPHdicj5yb2NrY2hpcC0mZ3Q7bGFuZXMpIHw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBQQ0lFX0NMSUVOVF9NT0RFX1JDIHw8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBQQ0lFX0NMSUVOVF9HRU5fU0VMXzIs
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgUENJ
RV9DTElFTlRfQkFTRSk7PGJyPg0KPC9ibG9ja3F1b3RlPjwvZGl2Pjxicj48L2Rpdj48ZGl2IGNs
YXNzPSJnbWFpbF9leHRyYSI+VGhhdCYjMzk7cyBwcmV0dHkgbXVjaCBhbG9uZyB0aGUgbGluZXMg
b2YgdGhlIGNvbXByb21pc2UgSSB3YXMgaW1wbHlpbmcgZWFybGllci4gU2VlbXMgZGVjZW50IHRv
IG1lLCBmb3Igd2hhdGV2ZXIgbXkgb3BpbmlvbiYjMzk7cyB3b3J0aCA6KTwvZGl2PjxkaXYgY2xh
c3M9ImdtYWlsX2V4dHJhIj48YnI+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPlRoYW5r
cyw8L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+QnJpYW48L2Rpdj48L2Rpdj4NCg==
--94eb2c0bdd76ae339a053b88acbd--
